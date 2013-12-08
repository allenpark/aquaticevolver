package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Tail3 extends DefaultImage
	{
		
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		public static var PolygonVertices:Array = new Array(
			//TODO: update these numbers with Nick's locations
			new b2Vec2(AEWorld.b2NumFromFlxNum(-27),AEWorld.b2NumFromFlxNum(4)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-27),AEWorld.b2NumFromFlxNum(-1)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-13),AEWorld.b2NumFromFlxNum(-11)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(2),AEWorld.b2NumFromFlxNum(-17)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(12),AEWorld.b2NumFromFlxNum(-17)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(20),AEWorld.b2NumFromFlxNum(-11)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(25),AEWorld.b2NumFromFlxNum(-3)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(25),AEWorld.b2NumFromFlxNum(4)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(19),AEWorld.b2NumFromFlxNum(12)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(11),AEWorld.b2NumFromFlxNum(16)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(0),AEWorld.b2NumFromFlxNum(16)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-12),AEWorld.b2NumFromFlxNum(12)));
		
		[Embed(source='../../res/Tail3.png')]
		private static const IMG:Class;
		
		public static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,36,WIDTH,HEIGHT);
		
		public static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,90, WIDTH, HEIGHT);
		public static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);
		
		override public function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
		
		override public function suggestedTailAnchor():b2Vec2
		{
			return SuggestedTailAnchor;;
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
