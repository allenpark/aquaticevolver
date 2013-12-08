package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Head3 extends DefaultImage
	{
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		public static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-8.0),AEWorld.b2NumFromFlxNum(41.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-29.0),AEWorld.b2NumFromFlxNum(24.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-52.0),AEWorld.b2NumFromFlxNum(18.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-41.0),AEWorld.b2NumFromFlxNum(1.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-26.0),AEWorld.b2NumFromFlxNum(-7.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-13.0),AEWorld.b2NumFromFlxNum(-36.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-5.0),AEWorld.b2NumFromFlxNum(-44.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(1.0),AEWorld.b2NumFromFlxNum(-44.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(10.0),AEWorld.b2NumFromFlxNum(-37.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(22.0),AEWorld.b2NumFromFlxNum(-8.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(40.0),AEWorld.b2NumFromFlxNum(3.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(49.0),AEWorld.b2NumFromFlxNum(16.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(45.0),AEWorld.b2NumFromFlxNum(20.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(24.0),AEWorld.b2NumFromFlxNum(25.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(6.0),AEWorld.b2NumFromFlxNum(41.0)));
		
		[Embed(source='../../res/Head3.png')]
		private static const Img:Class;
		
		public static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,97,WIDTH,HEIGHT);
		
		public static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,31, WIDTH, HEIGHT);
		public static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);
		
		override public function image():AEImage
		{
			return new AEImage(Img,WIDTH,HEIGHT);
		}
		
		override public function suggestedHeadAnchor():b2Vec2
		{
			return SuggestedHeadAnchor;
		}
		
		override public function suggestedAppendageSlots():Array
		{
			return SuggestedAppendageSlots;
		}
		
		override public function polygonVertices():Array
		{
			return PolygonVertices;
		}
	}
}
