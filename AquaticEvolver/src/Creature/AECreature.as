package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
	
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	public class AECreature
	{
		protected var _head:AEHead;
		protected var _torso:AETorso;
		protected var _tail:AETail;
		
		private static const HeadSwivel:Number = Math.PI/2.0;
		private static const TailSwivel:Number = Math.PI/2.0;
		
		public function AECreature(x:Number, y:Number, head:AEHead, torso:AETorso, tail:AETail)
		{
			_head = head;
			_torso = torso;
			_tail = tail;
			
			//TODO: is having a null torso vaild? eg. head-tail architecture?
			attachHeadTorsoTail();
		}
		
		private function attachHeadTorsoTail():void
		{
			//TODO: Should Head -- Torso -- Tail attaching with weld joints be included??
			
			//Head -- Torso
			new B2RevoluteJointBuilder().withBodyA(_head.headSegment.getBody()).withLocalAnchorA(_head.headAnchor)
				.withBodyB(_torso.headSegment.getBody()).withLocalAnchorB(_torso.headAnchor)
				.withEnabledLimit().withSwivelAngle(HeadSwivel)
				.build();
			
			//Torso -- Tail
			new B2RevoluteJointBuilder().withBodyA(_torso.tailSegment.getBody()).withLocalAnchorA(_torso.tailAnchor)
				.withBodyB(_tail.tailSegment.getBody()).withLocalAnchorB(_tail.tailAnchor)
				.withEnabledLimit().withSwivelAngle(TailSwivel)
				.build();
		}
	}
}