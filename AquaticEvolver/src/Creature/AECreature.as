package Creature
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	public class AECreature
	{
		private var _head:AEHead;
		private var _torso:AETorso;
		private var _tail:AETail;
		
		private static const HalfHeadSwivel:Number = Math.PI/4.0;
		private static const HalfTailSwivel:Number = Math.PI/4.0;
		
		public function AECreature(x:Number, y:Number, head:AEHead, torso:AETorso, tail:AETail)
		{
			_head = head;
			_torso = torso;
			_tail = tail;
			
			attachHeadTorsoTail();
		}
		
		private function attachHeadTorsoTail():void
		{
			//Head -- Torso
			var headJoint:b2RevoluteJointDef = new  b2RevoluteJointDef();
			headJoint.bodyA = _head.headSegment;
			headJoint.localAnchorA = _head.headAnchor;
			headJoint.bodyB = _torso.headSegment;
			headJoint.localAnchorB = _torso.headAnchor;
			//TODO: set reference angle appropriately
			headJoint.referenceAngle = 0;
			headJoint.enableLimit = true;
			headJoint.lowerAngle = -HalfHeadSwivel;
			headJoint.upperAngle = HalfHeadSwivel;
			AEWorld.AEB2World.CreateJoint(headJoint);
			
			//Torso -- Tail
			var tailJoint:b2RevoluteJointDef = new b2RevoluteJointDef();
			tailJoint.bodyA = _torso.tailSegment;
			tailJoint.localAnchorA = _torso.tailAnchor;
			tailJoint.bodyB = _tail.tailSegment;
			tailJoint.localAnchorB = _tail.tailAnchor;
			//TODO: set reference angle appropriately
			tailJoint.referenceAngle = 0;
			tailJoint.enableLimit = true;
			tailJoint.lowerAngle = -HalfTailSwivel;
			tailJoint.upperAngle = HalfTailSwivel;
			AEWorld.AEB2World.CreateJoint(tailJoint);
		}
	}
}