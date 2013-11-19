package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
		
	public class AECreature
	{
		protected var _head:AEHead;
		protected var _torso:AETorso;
		protected var _tail:AETail;
		
		private var _adaptations:Array;
		
		//TODO: appendage slots should be handled at the head-torso-tail level (only if specific appendages can only be attached to a specific part)
		private var _headAppendageSlots:Array;
		private var _torsoAppendageSlots:Array;
		private var _tailAppendageSlots:Array;
		
		private static const HeadSwivel:Number = Math.PI/2.0;
		private static const TailSwivel:Number = Math.PI/2.0;
		
		public function AECreature(x:Number, y:Number, head:AEHead, torso:AETorso, tail:AETail)
		{
			_head = head;
			_torso = torso;
			_tail = tail;
			
			//TODO: is having a null torso vaild? eg. head-tail architecture?
			attachHeadTorsoTail();
			
			initializeAppendageSlots();
		}
		
		private function attachHeadTorsoTail():void
		{
			//TODO: Should Head -- Torso -- Tail attaching with weld joints be included??
			
			//Head -- Torso
			new B2RevoluteJointBuilder(_head.headSegment.getBody(), _torso.headSegment.getBody(), _head.headAnchor, _torso.headAnchor)
				.withEnabledLimit().withSwivelAngle(HeadSwivel)
				.build();
			
			//Torso -- Tail
			new B2RevoluteJointBuilder(_torso.tailSegment.getBody(), _tail.tailSegment.getBody(), _torso.tailAnchor, _tail.tailAnchor)
				.withEnabledLimit().withSwivelAngle(TailSwivel)
				.build();
		}
		
		private function initializeAppendageSlots():void
		{
		}
		
		public function attachAppendage(appendage:Appendage):Boolean
		{
			return false;
		}
	}
}