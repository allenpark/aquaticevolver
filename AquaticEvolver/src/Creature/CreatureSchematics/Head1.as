package Creature.CreatureSchematics
{
	import Box2D.Common.Math.b2Vec2;

	public class Head1 extends Schematic
	{
		private static const width:Number = 128;
		private static const height:Number = 128;

		[Embed(source='../../res/Head1.png')]
		public static const img:Class;
				
		public static const headAnchor:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(36,64,width,height);
		
		public static const slot1:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(91,64, width, height);
		public static const potentialSlots:Array = new Array(slot1);
		
		
		public function Head1(appendageSlots:Array){
			super(appendageSlots);
		}
		
		override public function width():Number
		{
			return Head1.width;
		}
		
		override public function height():Number
		{
			return Head1.height;
		}	
		
		override public function img():Class
		{
			return Head1.img;
		}
	}
}