package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	
	import org.flixel.*;
	
	public class Spike extends Appendage
	{
		
		// spike joint location
		private var spikeJoint:b2Vec2 = new b2Vec2(0,45);
		
		// image
		[Embed(source='res/Spike1.png')]
		public static var spikeImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Spike(jointPos:b2Vec2)
		{
			super("spike", 20, true, 1);
			this.jointPos = jointPos;
			
			this.isAttack = true;
			this.attackDamage = 1;
			this.cost = 20;
			
			var world:b2World = AEWorld.AEB2World;
			
			// create the sprite
			var sprite:B2FlxSprite = new B2FlxSprite(0,0,spikeImg,32,128);
			this.add(sprite);
			
			// create the jointDef
			var weldJointDef:b2WeldJointDef = new b2WeldJointDef();
			weldJointDef.bodyA = AEWorld.player.get_obj();
			weldJointDef.bodyB = sprite.get_obj();
			weldJointDef.localAnchorA = jointPos;
			FlxG.log("AanchorCoords = " + weldJointDef.localAnchorA.x + ", " + weldJointDef.localAnchorA.y);
			weldJointDef.localAnchorB = convertToBox2D(spikeJoint);
			FlxG.log("BanchorCoords = " + weldJointDef.localAnchorB.x + ", " + weldJointDef.localAnchorB.y);
			weldJointDef.collideConnected = false;
			
			// add joint to world
			world.CreateJoint(weldJointDef);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}