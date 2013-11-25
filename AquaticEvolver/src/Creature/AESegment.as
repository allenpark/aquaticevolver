package Creature
{
	import flash.utils.Dictionary;
		
	import Box2D.Common.Math.b2Vec2;
	import Creature.Schematics.AESchematic;
	
	public class AESegment extends B2FlxSprite
	{	
		protected var _torsoSlots:Dictionary;
		public var appendageSlots:Array;
		
		/**
		 * The basic building block for creatures
		 * @param torsoSlots Dictionary mapping a torso slot label (string) to the local position of the torso slot (b2Vec2)
		 * @param adaptationSlots Array of b2Vec2 describing local position of adaptation slots
		 */
		/*
		public function AESegment(x:Number, y:Number, Graphic:Class=null, width:Number=0, height:Number=0, torsoSlots:Dictionary=null, appendageSlotLocations:Array=null)
		{
			super(x, y, Graphic, width, height);
			_torsoSlots = torsoSlots;
			this.appendageSlots = generateSlotsFromLocations(appendageSlotLocations);
		}
		*/
		
		/*
		public function AESegment(x:Number, y:Number, image:Image)
		{
			super(x,y, image.img(), image.width(), image.height());
			_torsoSlots = image.torsoSlots();
			this.appendageSlots = generateSlotsFromLocations(image.appendageSlots());
		}
		*/
		
		public function AESegment(x:Number, y:Number, schematic:AESchematic)
		{
			super(x,y, 0, schematic.img(), schematic.width(), schematic.height());
			_torsoSlots = schematic.torsoSlots();
			appendageSlots = schematic.appendageSlots();
		}
		
		public function generateSlotsFromLocations(slotLocations:Array):Array
		{
			var slots:Array = new Array();
			for (var location:b2Vec2 in slotLocations)
			{
				slots.push(new AESlot(this, location));
			}
			return slots;
		}
	}
}