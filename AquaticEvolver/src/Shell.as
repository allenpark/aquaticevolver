package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import Creature.AECreature;
	
	public class Shell extends Appendage
	{
		private var shell:B2FlxSprite;
		
		// spike joint location
		private var shellJoint:b2Vec2 = new b2Vec2(-3,34);
		
		// image
		[Embed(source='res/Shell1.png')]
		public static var shellImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Shell(jointPos:b2Vec2, jointAngle, creature:AECreature, segment:B2FlxSprite)
		{
			super(AdaptationType.SHELL, 20, true, 1, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			// create the sprite
			shell = new BoxShell(0,0,creature,shellImg,256,128);
			this.add(shell);
			
			// create the jointDef
			var weldJointDef:b2WeldJointDef = new b2WeldJointDef();
			weldJointDef.bodyA = segment.getBody();
			weldJointDef.bodyB = shell.getBody();
			weldJointDef.localAnchorA = jointPos;
			//			FlxG.log("AanchorCoords = " + weldJointDef.localAnchorA.x + ", " + weldJointDef.localAnchorA.y);
			weldJointDef.localAnchorB = convertToBox2D(shellJoint);
			//			FlxG.log("BanchorCoords = " + weldJointDef.localAnchorB.x + ", " + weldJointDef.localAnchorB.y);
			weldJointDef.collideConnected = false;
			weldJointDef.referenceAngle = jointAngle;
			
			// add joint to world
			world.CreateJoint(weldJointDef);
		}
		
		override public function color(color:Number):void {
			super.color(color);
			this.shell.color = color;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}