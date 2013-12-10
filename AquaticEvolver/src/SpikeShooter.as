package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import Creature.AECreature;
	
	public class SpikeShooter extends Appendage
	{
		[Embed(source='res/sfx/BubbleCannonShoot2.mp3')]
		public var SpikeShooterSFX:Class;
		
		// bubble gun joint locations
		private var spikeShooterJoint:b2Vec2 = new b2Vec2(0,32);
		
		private var spikeShooter:BoxSpikeShooter;
		
		private var jointAngleCorrection:Number = 0;
		
		public var creatureID:Number;
		
		// images
		
		//for now this is the bubble shooter image, the spike shooter may need its own image at some point

		[Embed(source='res/BubbleCannon1.png')]

		public static var spikeShooterImg:Class;
		
		public function SpikeShooter(jointPos:b2Vec2, jointAngle:Number, creature:AECreature, segment:B2FlxSprite)
		{
			this.creatureID = creatureID;
			jointAngle = jointAngle + jointAngleCorrection;
			super(AdaptationType.SPIKESHOOTER, 30, true, 1, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			
			// create the sprites
			//trace(creature);
			spikeShooter = new BoxSpikeShooter(0, 0, creature, this, spikeShooterImg, 128, 128);
			this.add(spikeShooter);
			
			// create the joint from base to creature
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = segment.getBody();
			revoluteJointDef.bodyB = spikeShooter.getBody();
			revoluteJointDef.localAnchorA = jointPos;
			//			FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(spikeShooterJoint);
			//			FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = jointAngle;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/4;
			revoluteJointDef.upperAngle = Math.PI/4;
			revoluteJointDef.collideConnected = false;
			world.CreateJoint(revoluteJointDef);			
		}
		
		override public function color(color:Number):void {
			super.color(color);
			this.spikeShooter.color = color;
		}
		
		override public function attack(point:FlxPoint):void
		{
			FlxG.play(SpikeShooterSFX);
			super.attack(point);
			// insert code to shoot a bubble here
			
			var headPoint:b2Vec2 = spikeShooter.getBody().GetPosition();
			var spawnPoint :b2Vec2 = calcBulletSpawnPoint(point, spikeShooter.getScreenXY(), headPoint);
			var orientation: Number = calcBulletOrientation (point, spikeShooter.getScreenXY());
			var spike:SpikeBullet = new SpikeBullet(spawnPoint, 16, 64, this.attackDamage, this.creature.getID(), orientation, 5, point);
			AEWorld.world.add(spike);
			var spikeBody:b2Body = spike.getBody();
			spikeBody.SetLinearVelocity(calcBulletVelocity(point, spikeShooter.getScreenXY()));//calcB2Impulse(point, bubbleGun.getScreenXY()));
		}
		
		protected function calcBulletVelocity(mousePoint:FlxPoint, bodyPoint:FlxPoint):b2Vec2 {
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = 3;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
		}
		protected function calcBulletOrientation(mousePoint:FlxPoint, bodyPoint:FlxPoint):Number {
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x) + Math.PI/2;
			return (angle);
		}
		
		protected function calcBulletSpawnPoint(mousePoint:FlxPoint, bodyPoint:FlxPoint, gunPoint:b2Vec2):b2Vec2 {
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = .7;
			var xSpawn:Number = magnitude * Math.cos(angle) + gunPoint.x;
			var ySpawn:Number = magnitude * Math.sin(angle) + gunPoint.y;
			return new b2Vec2(xSpawn,ySpawn);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}