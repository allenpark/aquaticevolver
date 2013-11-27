package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;

	public class Head1
	{
		/**
		 * Vertices defining the verteces for the shape
		 */
		public static var polygonVerteces:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(0),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50), AEWorld.b2NumFromFlxNum(50)));
		private static const Width:Number = 128;
		private static const Height:Number = 128;

		[Embed(source='../../res/Head1.png')]
		private static const Img:Class;
				
		public static const suggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(36,64,Width,Height);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(91,64, Width, Height);
		public static const suggestedAppendageSlots:Array = new Array(suggestedAppendageSlot1);
		
		public static function image():AEImage
		{
			return new AEImage(Img,Width,Height);
		}
	}
}