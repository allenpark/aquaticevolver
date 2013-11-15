package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	
	import org.flixel.*;
	
	public class Spike extends Adaptation
	{
		// joint location in image coords
		private var spikeJoint:b2Vec2 = new b2Vec2(16,100);
		
		public function Spike(imagePos:b2Vec2, angle:Number)
		{
			super(name, imagePos, angle);
			this.name = "tentacle";
			this.isAttack = true;
			this.attackDamage = 1;
			this.cost = 20;
		}
	}
}