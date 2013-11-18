package Creature
{
	public class AESegment extends B2FlxSprite
	{	
		protected var torsoSlots:Array;
		protected var adaptationSlots:Array;
		
		
		public function AESegment(x:int, y:int, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			super(x, y, Graphic, width, height);
			
		}
	}
}