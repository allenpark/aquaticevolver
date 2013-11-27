package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;

	public class Torso1
	{
		
		/**
		 * Vertices defining the verteces for the shape
		 */
		public static var polygonVerteces:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(0),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50), AEWorld.b2NumFromFlxNum(50)));
		
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		[Embed(source='../../res/Torso1.png')]
		private static const IMG:Class;
		
		public static const suggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(96,64,WIDTH,HEIGHT);
		public static const suggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(28,64,WIDTH,HEIGHT);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(93,87, WIDTH, HEIGHT);
		public static const suggestedAppendageSlot2:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(65,98, WIDTH, HEIGHT);
		public static const suggestedAppendageSlot3:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(34,87, WIDTH, HEIGHT);
		public static const suggestedAppendageSlot4:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(93,23, WIDTH, HEIGHT);
		public static const suggestedAppendageSlot5:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(65,34, WIDTH, HEIGHT);
		public static const suggestedAppendageSlot6:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(34,23, WIDTH, HEIGHT);
		
		public static const suggestedAppendageSlots:Array = new Array(	suggestedAppendageSlot1, 
																suggestedAppendageSlot2, 
																suggestedAppendageSlot3, 
																suggestedAppendageSlot4, 
																suggestedAppendageSlot5, 
																suggestedAppendageSlot6);
		
		public static function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
	}
}