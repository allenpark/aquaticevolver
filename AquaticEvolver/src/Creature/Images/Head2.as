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
		public static var PolygonVertices:Array = new Array(
			//TODO: update these numbers with Nick's locations
			new b2Vec2(AEWorld.b2NumFromFlxNum(56),AEWorld.b2NumFromFlxNum(-4)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(35),AEWorld.b2NumFromFlxNum(-30)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-1),AEWorld.b2NumFromFlxNum(-36)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-41),AEWorld.b2NumFromFlxNum(-29)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-56),AEWorld.b2NumFromFlxNum(-3)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-36),AEWorld.b2NumFromFlxNum(27)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(1),AEWorld.b2NumFromFlxNum(35)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(39),AEWorld.b2NumFromFlxNum(28)));
		
		[Embed(source='../../res/Head2.png')]
		private static const Img:Class;
		
		public static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,86,WIDTH,HEIGHT);
		
		public static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,35, WIDTH, HEIGHT);
		public static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);
		
		public static function image():AEImage
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
