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
	
	public class Spike extends Appendage
	{
		private var spike:B2FlxSprite;
		
		// spike joint location
		private var spikeJoint:b2Vec2 = new b2Vec2(0,45);
		
		// image
		[Embed(source='res/Spike1.png')]
		public static var spikeImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Spike(jointPos:b2Vec2, jointAngle, creature:AECreature, segment:B2FlxSprite)
		{
			super(AdaptationType.SPIKE, 20, true, 1, jointPos, jointAngle, creature, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			// create the sprite
			spike = new BoxSpike(0,0,creature,spikeImg,32,128);
			this.add(spike);
			
			// create the jointDef
			var weldJointDef:b2WeldJointDef = new b2WeldJointDef();
			weldJointDef.bodyA = segment.getBody();
			weldJointDef.bodyB = spike.getBody();
			weldJointDef.localAnchorA = jointPos;
//			FlxG.log("AanchorCoords = " + weldJointDef.localAnchorA.x + ", " + weldJointDef.localAnchorA.y);
			weldJointDef.localAnchorB = convertToBox2D(spikeJoint);
//			FlxG.log("BanchorCoords = " + weldJointDef.localAnchorB.x + ", " + weldJointDef.localAnchorB.y);
			weldJointDef.collideConnected = false;
			weldJointDef.referenceAngle = jointAngle;
			
			// add joint to world
			world.CreateJoint(weldJointDef);
		}
		
		override public function color(color:Number):void {
			super.color(color);
			this.spike.color = color;
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}