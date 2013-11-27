package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	import Creature.Schematics.AESchematic;

	public class Tail1
	{
		
		/**
		 * Vertices defining the verteces for the shape
		 */
		public static var polygonVerteces:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(0),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50), AEWorld.b2NumFromFlxNum(50)));
		
		private static const WIDTH:Number = 64;
		private static const HEIGHT:Number = 64;
		
		[Embed(source='../../res/Tail1.png')]
		private static const IMG:Class;
		
		public static const suggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(50,32,WIDTH,HEIGHT);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(11,32, WIDTH, HEIGHT);
		public static const suggestedAppendageSlots:Array = new Array(suggestedAppendageSlot1);

		public static function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
	}
}