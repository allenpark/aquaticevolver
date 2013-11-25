package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
			
	public class AECreature
	{
		protected var _head:AEHead;
		protected var _torso:AETorso;
		protected var _tail:AETail;
		
		private var _adaptations:Array;
		
		private var _unoccupiedAppendageSlots:Array;
		private var _occupiedAppendageSlots:Array;
		
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
		
		public static function addCreatureToWorld(creature:AECreature, world:AEWorld):void
		{
			AEHead.addHeadToWorld(creature._head, world);
			AETorso.addTorsoToWorld(creature._torso, world);
			AETail.addTailToWorld(creature._tail, world);
		}
		
		private function attachHeadTorsoTail():void
		{
			//TODO: Should Head -- Torso -- Tail attaching with weld joints be included?? Currently, only revolute joints are used to connect head-torso-tail together
			
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
			_unoccupiedAppendageSlots = new Array()
				.concat(_head.getAppendageSlots())
				.concat(_torso.getAppendageSlots())
				.concat(_tail.getAppendageSlots());
			
			_occupiedAppendageSlots = new Array();
		}
		
		public function attachAppendage(appendage:Appendage):Boolean
		{
			if (_unoccupiedAppendageSlots.length == 0)
			{
				//TODO: Evolve a bigger body & attack the new appendage!
				return false;
			}
			else
			{
				var appendageSlot:AESlot = _unoccupiedAppendageSlots.pop();
				//TODO: attach appendage to appendageSlot
				_occupiedAppendageSlots.push(appendageSlot);
				return true;
			}
		}
	}
}