package Creature
{

	public class AESegment extends B2FlxSprite
	{	
		protected var _unoccupiedTorsoSlots:Array;
		protected var _occupiedTorsoSlots:Array;
		public var appendageSlots:Array;
		
		/**
		 * The basic building block for creatures
		 * @param torsoSlots Array of b2Vec2 describing local position of torso slots
		 * @param adaptationSlots Array of b2Vec2 describing local position of adaptation slots
		 */
		public function AESegment(x:int, y:int, Graphic:Class=null, width:Number=0, height:Number=0, torsoSlots:Array=null, adaptationsSlots:Array=null)
		{
			super(x, y, Graphic, width, height);
			_unoccupiedTorsoSlots = torsoSlots;
			_occupiedTorsoSlots = new Array();
			this.appendageSlots = adaptationsSlots;
		}
		
		/* This should be done at the torso or creature level
		public function attachAppendage(appendage:Appendage):Boolean
		{
			if (_unoccupiedAppendageSlots.length == 0){
				return false;
			}else {
				var adaptationSlot:b2Vec2 = _unoccupiedAppendageSlots.pop();
				//TODO: attach appendage at adaptation slot
				_occupiedAppendageSlots.push(adaptationSlot);
				return true;
			}
		}
		*/
	}
}