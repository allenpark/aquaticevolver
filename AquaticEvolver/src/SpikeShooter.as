package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxPoint;
	
	public class SpikeShooter extends Appendage
	{
		// bubble gun joint locations
		private var spikeShooterJoint:b2Vec2 = new b2Vec2(31,11);
		
		private var spikeShooter:BoxBubbleGun;
		
		private var jointAngleCorrection:Number = Math.PI/2;
		
		// images
		
		//for now this is the bubble shooter image, the spike shooter may need its own image at some point
		[Embed(source='res/bubbleSnapper1.png')]
		public static var spikeShooterImg:Class;
		
		public function SpikeShooter(jointPos:b2Vec2, jointAngle:Number, owner:*, segment:B2FlxSprite)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.SPIKESHOOTER, 30, true, 2, jointPos, jointAngle, owner, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			
			// create the sprites
			trace(owner);
			spikeShooter = new BoxBubbleGun(0, 0, owner, this, spikeShooterImg, 128, 128);
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
			revoluteJointDef.lowerAngle = -3*Math.PI/4;
			revoluteJointDef.upperAngle = 3*Math.PI/4;
			revoluteJointDef.collideConnected = false;
			world.CreateJoint(revoluteJointDef);			
		}
		
		override public function attack(point:FlxPoint):void
		{
			super.attack(point);
			// insert code to shoot a bubble here
			
			var headPoint:b2Vec2 = spikeShooter.getBody().GetPosition();
			var spawnPoint :b2Vec2 = calcBulletSpawnPoint(point, spikeShooter.getScreenXY(), headPoint);
			var orientation: Number = calcBulletOrientation (point, spikeShooter.getScreenXY());
			var spike:SpikeBullet = new SpikeBullet(spawnPoint, this.creature, this, 16, 64,orientation, 5, point);
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