package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	public class Mandible extends Appendage
	{
		// mandible joint locations
		private var mandibleBaseJoint:b2Vec2 = new b2Vec2(-15,0);
		private var mandibleBaseJawJoint:b2Vec2 = new b2Vec2(6,-11);
		private var mandibleBaseOtherJawJoint:b2Vec2 = new b2Vec2(6,11);
		private var mandibleJawJoint:b2Vec2 = new b2Vec2(-28,11);
		private var mandibleOtherJawJoint:b2Vec2 = new b2Vec2(-28,-11);
		
		private var jointAngleCorrection:Number = -Math.PI/2;
		
		// images
		[Embed(source='res/mandibleBase1.png')]
		public static var mandibleBaseImg:Class;
		[Embed(source='res/mandibleJawPiece1.png')]
		public static var mandibleJawImg:Class;
		[Embed(source='res/mandibleOtherJawPiece1.png')]
		public static var mandibleOtherJawImg:Class;
		
		public function Mandible(jointPos:b2Vec2, jointAngle, owner:Creature)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.MANDIBLE, 30, true, 2, jointPos, jointAngle, owner);
			
			var world:b2World = AEWorld.AEB2World;
			
			var base:BoxMandibleBase;
			var jaw:BoxMandibleJaw;
			var otherJaw:BoxMandibleJaw;
			
			var revoluteJointDef:b2RevoluteJointDef;
				
				// create the sprites
				trace(owner);
				base = new BoxMandibleBase(0,0,owner,mandibleBaseImg,64,64);
				this.add(base);
				jaw = new BoxMandibleJaw(0,0,owner,mandibleJawImg,128,64);
				this.add(jaw);
				otherJaw = new BoxMandibleJaw(0,0,owner,mandibleOtherJawImg,128,64);
				this.add(otherJaw);
				
				// create the joint from base to creature
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = owner.getBody();
				revoluteJointDef.bodyB = base.getBody();
				revoluteJointDef.localAnchorA = jointPos;
				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(mandibleBaseJoint);
				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
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
				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(mandibleJawJoint);
				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.referenceAngle = -Math.PI/4;
				revoluteJointDef.enableLimit = true;
				revoluteJointDef.lowerAngle = -Math.PI/4;
				revoluteJointDef.upperAngle = 1.05*Math.PI/4;
				revoluteJointDef.collideConnected = false;
				world.CreateJoint(revoluteJointDef);
				
				// create the joint from base to otherJaw
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = base.getBody();
				revoluteJointDef.bodyB = otherJaw.getBody();
				revoluteJointDef.localAnchorA = convertToBox2D(mandibleBaseOtherJawJoint);
				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(mandibleOtherJawJoint);
				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.referenceAngle = +Math.PI/4;
				revoluteJointDef.enableLimit = true;
				revoluteJointDef.lowerAngle = -1.05*Math.PI/4;
				revoluteJointDef.upperAngle = Math.PI/4;
				revoluteJointDef.collideConnected = false;
				world.CreateJoint(revoluteJointDef);			
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}