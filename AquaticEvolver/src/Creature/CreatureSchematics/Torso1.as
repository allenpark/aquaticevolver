package Creature.CreatureSchematics
{
	import Box2D.Common.Math.b2Vec2;

	public class Torso1 extends Schematic
	{
		public static const width:Number = 128;
		public static const height:Number = 128;
		
		[Embed(source='../../res/Torso1.png')]
		public static const img:Class;
		
		public static const headAnchor:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(96,64,width,height);
		public static const tailAnchor:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(28,64,width,height);
		
		public static const slot1:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(93,87, width, height);
		public static const slot2:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(65,98, width, height);
		public static const slot3:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(34,87, width, height);
		public static const slot4:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(93,23, width, height);
		public static const slot5:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(65,34, width, height);
		public static const slot6:b2Vec2 = Schematic.getB2Vec2FromFlxCoords(34,23, width, height);
		public static const potentialSlots:Array = new Array(slot1, slot2, slot3, slot4, slot5, slot6);
				
		public function Torso1(appendageSlots:Array, torsoSlots:Array)
		{
			super(appendageSlots, torsoSlots);
		}
		
		override public function width():Number
		{
			return Torso1.width;
		}
		
		override public function height():Number
		{
			return Torso1.height;
		}
		
		override public function img():Class
		{
			return Torso1.img;
		}
	}
}