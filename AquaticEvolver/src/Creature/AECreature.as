package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
	
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
			
	public class AECreature
	{
		protected var _head:AEHead;
		protected var _torso:AETorso;
		protected var _tail:AETail;
		
		private var _adaptations:Array;
		
		private var _unoccupiedAppendageSlots:Array;
		private var _occupiedAppendageSlots:Array;
		
		protected var _headTorsoJoint:b2RevoluteJoint;
		protected var _torsoTailJoint:b2RevoluteJoint;
		
		private static const HeadSwivel:Number = Math.PI/2.0;
		private static const TailSwivel:Number = Math.PI/2.0;
		
		public var creatureType:Number;
		
		protected var speed:Number = 10;
		
		public function AECreature(type:Number, x:Number, y:Number, head:AEHead, torso:AETorso, tail:AETail)
		{
			_head = head;
			_torso = torso;
			_tail = tail;
			
			creatureType = type;
			//TODO: is having a null torso vaild? eg. head-tail architecture?
			attachHeadTorsoTail();
			
			initializeAppendageSlots();
			
			ownBodies(type);
			//TODO: Should this be done outside the constructor?
			addToWorld();
		}
		
		public function attachAppendage(appendageType:Number):Boolean
		{
			if (_unoccupiedAppendageSlots.length == 0)
			{
				//TODO: Evolve a bigger body & attack the new appendage!
				return false;
			}
			else
			{
				var appendageSlot:AESlot = _unoccupiedAppendageSlots.pop();
				//TODO: appendage locations need to be rotated with body
				trace("appendage slot y: " + appendageSlot.slotLocation.y +"appendage slot x"+appendageSlot.slotLocation.x);
				var angle:Number = Math.atan(appendageSlot.slotLocation.y/appendageSlot.slotLocation.x) - Math.PI;
				trace("Appendage Angle: "+angle);
				var appendage:Appendage = Appendage.createAppendageWithType(appendageType,appendageSlot.slotLocation, angle, this, appendageSlot.segment);
				//TODO: keep track of appendages... in adaptations array? or separate appendage array?
				_occupiedAppendageSlots.push(appendageSlot);
				return true;
			}
		}
		
		public function kill():void
		{
			_head.kill();
			_torso.kill();
			_tail.kill();
		}
		
		public function getX():Number
		{
			return AEWorld.flxNumFromB2Num(_head.headSegment.getBody().GetPosition().x);
		}
		
		public function getY():Number
		{
			return AEWorld.flxNumFromB2Num(_head.headSegment.getBody().GetPosition().y);
		}
		
		private function ownBodies(type:Number):void
		{
			_head.ownBodies(this,type);
			_torso.ownBodies(this,type);
			_tail.ownBodies(this,type);
		}
		
		private function addToWorld():void
		{
			_head.addToWorld();
			_torso.addToWorld();
			_tail.addToWorld();
		}
		
		private function attachHeadTorsoTail():void
		{
			//TODO: Should Head -- Torso -- Tail attaching with weld joints be included?? Currently, only revolute joints are used to connect head-torso-tail together
			
			//Head -- Torso
			_headTorsoJoint = new B2RevoluteJointBuilder(_head.headSegment.getBody(), _torso.headSegment.getBody(), _head.headAnchor, _torso.headAnchor)
				.withEnabledLimit().withSwivelAngle(HeadSwivel)
				.build();
			
			//Torso -- Tail
			_torsoTailJoint = new B2RevoluteJointBuilder(_torso.tailSegment.getBody(), _tail.tailSegment.getBody(), _torso.tailAnchor, _tail.tailAnchor)
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
	}
}