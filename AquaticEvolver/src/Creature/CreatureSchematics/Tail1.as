package Creature.CreatureSchematics
{
	import Box2D.Common.Math.b2Vec2;

	public class Tail1 extends Schematic
	{
		public static const width:Number = 64;
		public static const height:Number = 64;
		
		[Embed(source='../../res/Tail1.png')]
		public static const img:Class;
		
		public static const tailAnchor:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(50,32,width,height);
		
		public static const slot1:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(11,32, width, height);
		public static const potentialSlots:Array = new Array(slot1);
		
		private var _appendageSlots:Array;
		
		public function Tail1(appendageSlots:Array)
		{
			super(appendageSlots);
		}
		
		override public function width():Number
		{
			return Tail1.width;
		}
		
		override public function height():Number
		{
			return Tail1.height;
		}
		
		override public function img():Class
		{
			return Tail1.img;
		}
	}
}