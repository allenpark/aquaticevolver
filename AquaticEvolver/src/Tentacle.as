package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	
	public class Tentacle extends Appendage
	{
		[Embed(source='res/sfx/Swipe1.mp3')]
		public var TentacleSFX1:Class;
		[Embed(source='res/sfx/Swipe2.mp3')]
		public var TentacleSFX2:Class;
		[Embed(source='res/sfx/Swipe3.mp3')]
		public var TentacleSFX3:Class;
		[Embed(source='res/sfx/Swipe4.mp3')]
		public var TentacleSFX4:Class;
		[Embed(source='res/sfx/Swipe5.mp3')]
		public var TentacleSFX5:Class;
		[Embed(source='res/sfx/Swipe6.mp3')]
		public var TentacleSFX6:Class;
		[Embed(source='res/sfx/Swipe7.mp3')]
		public var TentacleSFX7:Class;
		[Embed(source='res/sfx/Swipe8.mp3')]
		public var TentacleSFX8:Class;
		[Embed(source='res/sfx/Swipe9.mp3')]
		public var TentacleSFX9:Class;
		public var tentacleNoises:Array = new Array();
		private var tentacleMidSegments:int = 4;
		private var tentacleHead:BoxTentacleHead;
		
		// tentacle joint locations
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(0,-15);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(0,15);
		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(0,19);
		private var midSegments:Array = new Array();
		
		private var jointAngleCorrection:Number = Math.PI;
		
		// images
		[Embed(source='res/tentacleHead1.png')]
		public static var tentacleHeadImg:Class;
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Tentacle(jointPos:b2Vec2, jointAngle:Number, creature:AECreature, segment:B2FlxSprite)
		{
			tentacleNoises[0] = TentacleSFX1;
			tentacleNoises[1] = TentacleSFX2;
			tentacleNoises[2] = TentacleSFX3;
			tentacleNoises[3] = TentacleSFX4;
			tentacleNoises[4] = TentacleSFX5;
			tentacleNoises[5] = TentacleSFX6;
			tentacleNoises[6] = TentacleSFX7;
			tentacleNoises[7] = TentacleSFX8;
			tentacleNoises[8] = TentacleSFX9;
			jointAngle = jointAngle + jointAngleCorrection;
			super(AdaptationType.TENTACLE, 50, true, 2, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			var prevSprite:B2FlxSprite = segment;
			var sprite:B2FlxSprite;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			var flixelPos;
			
			var xOffset:Number = 0*Math.cos(jointAngle);
			var yOffset:Number = 30*Math.sin(jointAngle);
			for (var i:int = 0; i < tentacleMidSegments; i++) {
				
				// create the sprite
				trace(creature);
				
				flixelPos = convertJointPosToFlixel(segment,jointPos);
				sprite = new BoxTentacleMid(flixelPos.x, flixelPos.y, creature, this, tentacleMidImg, 32, 64);
				
				flixelPos.x += xOffset;
				flixelPos.y += yOffset;
				
				sprite.angle = jointAngle*360/(2*Math.PI);

				midSegments.push(sprite);
				this.add(sprite);
				
				// create the jointDef
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = prevSprite.getBody();
				revoluteJointDef.bodyB = sprite.getBody();
				if (i == 0) {
					revoluteJointDef.localAnchorA = jointPos;
					revoluteJointDef.referenceAngle = jointAngle;
				} else {
					revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
					revoluteJointDef.referenceAngle = 0;
				}
//				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(tentacleSegmentStartJoint);
//				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.enableLimit = true;
				revoluteJointDef.lowerAngle = -Math.PI/4;
				revoluteJointDef.upperAngle = Math.PI/4;
				revoluteJointDef.collideConnected = false;
				world.CreateJoint(revoluteJointDef);
				
				prevSprite = sprite;
			}
			
			// create the sprite
			flixelPos = convertJointPosToFlixel(segment,jointPos);
			tentacleHead = new BoxTentacleHead(flixelPos.x, flixelPos.y, creature, this, tentacleHeadImg, 32, 64);
			tentacleHead.angle = jointAngle*360/(2*Math.PI);

			this.add(tentacleHead);
			
			// create the jointDef
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = prevSprite.getBody();
			revoluteJointDef.bodyB = sprite.getBody();
			revoluteJointDef.bodyA = prevSprite.getBody();
			revoluteJointDef.bodyB = tentacleHead.getBody();
			if (tentacleMidSegments == 0)
			{
				revoluteJointDef.localAnchorA = new b2Vec2(jointPos.x,jointPos.y);
			}else
			{
				revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
			}
//			FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(tentacleHeadJoint);
//			FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = Math.PI;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/4;
			revoluteJointDef.upperAngle = Math.PI/4;
			revoluteJointDef.collideConnected = false;
			
			// add joint to world
			world.CreateJoint(revoluteJointDef);
		}
		
		override public function color(color:Number):void {
			super.color(color);
			this.tentacleHead.color = color;
			for each (var mid:BoxTentacleMid in this.midSegments) {
				mid.color = color;
			}			
		}
		
		override public function attack(point:FlxPoint):void
		{
			var randomSong = FlxU.getRandom(tentacleNoises,0, 9);
			FlxG.play(randomSong);			
			super.attack(point);
			//trace("tentacle attacking");
			
			var tentacleBody:b2Body = tentacleHead.getBody();
			//var headPoint:FlxPoint = new FlxPoint(tentacleBody.GetPosition().x, tentacleBody.GetPosition().y);
			var impulse:b2Vec2 = calcB2Impulse(point, tentacleHead.getScreenXY());
			impulse.Multiply(1200);
			tentacleBody.ApplyImpulse(impulse, tentacleBody.GetPosition());
		}
		
		override public function aim(point:FlxPoint):void
		{
			var headPoint:FlxPoint = new FlxPoint(this.creature.getX(), this.creature.getY());
			var tentacleBody:b2Body = tentacleHead.getBody();
			tentacleBody.ApplyImpulse(calcB2Impulse(point, headPoint), tentacleBody.GetPosition());
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}
