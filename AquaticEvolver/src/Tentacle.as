package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.*;
	
	public class Tentacle extends Adaptation
	{
		private var tentacleSegments:int = 5;
		
		// joint locations in image coords
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(16,20);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(16,44);
		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(16,13);
		
		public function Tentacle(name:String, imagePos:b2Vec2, angle:Number)
		{
			super(name, imagePos, angle);
			this.name = "tentacle";
		}
	}
}