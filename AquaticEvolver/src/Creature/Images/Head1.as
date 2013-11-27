package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;

	public class Head1
	{
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		public static var polygonVerteces:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-WIDTH)/4.0,AEWorld.b2NumFromFlxNum(-HEIGHT)/2.0),
			new b2Vec2(AEWorld.b2NumFromFlxNum(WIDTH)/4.0,AEWorld.b2NumFromFlxNum(-HEIGHT)/2.0),
			new b2Vec2(AEWorld.b2NumFromFlxNum(WIDTH)/4.0, AEWorld.b2NumFromFlxNum(HEIGHT)/2.0),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-WIDTH)/4.0, AEWorld.b2NumFromFlxNum(HEIGHT)/2.0));

		[Embed(source='../../res/Head1.png')]
		private static const Img:Class;
				
		public static const suggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(36,64,WIDTH,HEIGHT);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(91,64, WIDTH, HEIGHT);
		public static const suggestedAppendageSlots:Array = new Array(suggestedAppendageSlot1);
		
		public static function image():AEImage
		{
			return new AEImage(Img,WIDTH,HEIGHT);
		}
	}
}