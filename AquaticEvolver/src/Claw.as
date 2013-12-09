package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	
	public class Claw extends Appendage
	{
		[Embed(source='res/sfx/VoiceClacker1.mp3')]
		public var ClawSFX:Class;
		private var tentacleMidSegments:int = 3;
		
		// tentacle joint locations
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(0,-15);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(0,15);
		private var midSegments:Array = new Array();
		
		// mandible joint locations
		private var mandibleBaseJoint:b2Vec2 = new b2Vec2(0,15);
		private var mandibleBaseJawJoint:b2Vec2 = new b2Vec2(-17,-4);
		private var mandibleBaseOtherJawJoint:b2Vec2 = new b2Vec2(17,-4);
		private var mandibleJawJoint:b2Vec2 = new b2Vec2(-1,36);
		private var mandibleOtherJawJoint:b2Vec2 = new b2Vec2(1,36);
		
		private var base:BoxMandibleBase;
		private var jaw:BoxMandibleJaw;
		private var otherJaw:BoxMandibleJaw;
		
		private var jointAngleCorrection:Number = Math.PI;
		
		// images
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		[Embed(source='res/mandibleBase1.png')]
		public static var mandibleBaseImg:Class;
		[Embed(source='res/gnarlyMandibleJawPieceLeft1.png')]
		public static var mandibleJawImg:Class;
		[Embed(source='res/gnarlyMandibleJawPieceRight1.png')]
		public static var mandibleOtherJawImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Claw(jointPos:b2Vec2, jointAngle:Number, creature:AECreature, segment:B2FlxSprite)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.CLAW, 50, true, 2, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			var prevSprite:B2FlxSprite = segment;
			var sprite:B2FlxSprite;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			var flixelPos;
			
			var xOffset:Number = 0*Math.cos(jointAngle);
			var yOffset:Number = 30*Math.sin(jointAngle);
			// create the tentacle part
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
			
			// create the mandible part
			base = new BoxMandibleBase(0, 0, creature, this, mandibleBaseImg, 64, 64);
			this.add(base);
			jaw = new BoxMandibleJaw(0, 0, creature, this, mandibleJawImg, 128, 128);
			this.add(jaw);
			otherJaw = new BoxMandibleJaw(0, 0, creature, this, mandibleOtherJawImg, 128, 128);
			this.add(otherJaw);
			
			// create the joint from base to end of tentacle
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = prevSprite.getBody();
			revoluteJointDef.bodyB = base.getBody();
			if (tentacleMidSegments == 0)
			{
				revoluteJointDef.localAnchorA = new b2Vec2(jointPos.x,jointPos.y);
			}else
			{
				revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
			}
			//				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(mandibleBaseJoint);
			//				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = Math.PI;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/8;
			revoluteJointDef.upperAngle = Math.PI/8;
			revoluteJointDef.collideConnected = false;
			world.CreateJoint(revoluteJointDef);
			
			// create the joint from base to jaw
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = base.getBody();
			revoluteJointDef.bodyB = jaw.getBody();
			revoluteJointDef.localAnchorA = convertToBox2D(mandibleBaseJawJoint);
			//				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(mandibleJawJoint);
			//				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = 0;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/4;
			revoluteJointDef.upperAngle = 0;
			revoluteJointDef.collideConnected = false;
			revoluteJointDef.enableMotor = true;
			revoluteJointDef.motorSpeed = 2;
			revoluteJointDef.maxMotorTorque = 1;
			world.CreateJoint(revoluteJointDef);
			
			// create the joint from base to otherJaw
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = base.getBody();
			revoluteJointDef.bodyB = otherJaw.getBody();
			revoluteJointDef.localAnchorA = convertToBox2D(mandibleBaseOtherJawJoint);
			//				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(mandibleOtherJawJoint);
			//				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = 0;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = 0;
			revoluteJointDef.upperAngle = Math.PI/4;
			revoluteJointDef.collideConnected = false;
			revoluteJointDef.enableMotor = true;
			revoluteJointDef.motorSpeed = -2;
			revoluteJointDef.maxMotorTorque = 1;
			world.CreateJoint(revoluteJointDef);
		}
		
		override public function color(color:Number):void {
			super.color(color);
//			this.mandibleBase.color = color;
			//			this.mandibleJaw.color = color;
			//			this.mandibleOtherJaw.color = color;
			for each (var mid:BoxTentacleMid in this.midSegments) {
				mid.color = color;
			}
		}
		
		override public function attack(point:FlxPoint):void
		{
			FlxG.play(ClawSFX);
		}
		
		override public function aim(point:FlxPoint):void
		{
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}