package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import Creature.AECreature;
	
	public class Mandible extends Appendage
	{
		// mandible joint locations
		private var mandibleBaseJoint:b2Vec2 = new b2Vec2(0,15);
		private var mandibleBaseJawJoint:b2Vec2 = new b2Vec2(-17,-4);
		private var mandibleBaseOtherJawJoint:b2Vec2 = new b2Vec2(17,-4);
		private var mandibleJawJoint:b2Vec2 = new b2Vec2(-1,36);
		private var mandibleOtherJawJoint:b2Vec2 = new b2Vec2(1,36);
		
		private var jointAngleCorrection:Number = 0;
		private var base:BoxMandibleBase;
		private var jaw:BoxMandibleJaw;
		private var otherJaw:BoxMandibleJaw;
		
		// images
		[Embed(source='res/mandibleBase1.png')]
		public static var mandibleBaseImg:Class;
		[Embed(source='res/gnarlyMandibleJawPieceLeft1.png')]
		public static var mandibleJawImg:Class;
		[Embed(source='res/gnarlyMandibleJawPieceRight1.png')]
		public static var mandibleOtherJawImg:Class;
		
		public function Mandible(jointPos:b2Vec2, jointAngle, creature:AECreature, segment:B2FlxSprite)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AdaptationType.MANDIBLE, 30, true, 2, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			
			var revoluteJointDef:b2RevoluteJointDef;
				
				// create the sprites
				trace(creature);
				base = new BoxMandibleBase(0, 0, creature, this, mandibleBaseImg, 64, 64);
				this.add(base);
				jaw = new BoxMandibleJaw(0, 0, creature, this, mandibleJawImg, 128, 128);
				this.add(jaw);
				otherJaw = new BoxMandibleJaw(0, 0, creature, this, mandibleOtherJawImg, 128, 128);
				this.add(otherJaw);
				
				// create the joint from base to creature
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = segment.getBody();
				revoluteJointDef.bodyB = base.getBody();
				revoluteJointDef.localAnchorA = jointPos;
//				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(mandibleBaseJoint);
//				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.referenceAngle = jointAngle;
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
			base.color = color;
			jaw.color = color;
			otherJaw.color = color;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}