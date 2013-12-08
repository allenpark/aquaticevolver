package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Head2 extends DefaultImage
	{
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		public static var polygonVerteces:Array = new Array(
			//TODO: update these numbers with Nick's locations
			new b2Vec2(AEWorld.b2NumFromFlxNum(-5.0),AEWorld.b2NumFromFlxNum(35.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-24.0),AEWorld.b2NumFromFlxNum(22.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-51.0),AEWorld.b2NumFromFlxNum(12.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-52.0),AEWorld.b2NumFromFlxNum(0.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-37.0),AEWorld.b2NumFromFlxNum(-23.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-14.0),AEWorld.b2NumFromFlxNum(-39.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(9.0),AEWorld.b2NumFromFlxNum(-39.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(35.0),AEWorld.b2NumFromFlxNum(-23.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(48.0),AEWorld.b2NumFromFlxNum(-1.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(47.0),AEWorld.b2NumFromFlxNum(13.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(25.0),AEWorld.b2NumFromFlxNum(21.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(7.0),AEWorld.b2NumFromFlxNum(35.0)));
		
		[Embed(source='../../res/Head2.png')]
		private static const Img:Class;
		
		public static const suggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,86,WIDTH,HEIGHT);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,35, WIDTH, HEIGHT);
		public static const suggestedAppendageSlots:Array = new Array(suggestedAppendageSlot1);
		
		public static function image():AEImage
		{
			return new AEImage(Img,WIDTH,HEIGHT);
		}
	}
}
