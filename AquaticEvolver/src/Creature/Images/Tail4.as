package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Tail4 extends DefaultImage
	{
		
		private static const WIDTH:Number = 32;
		private static const HEIGHT:Number = 64;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-4.0),AEWorld.b2NumFromFlxNum(29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-9.0),AEWorld.b2NumFromFlxNum(22.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-9.0),AEWorld.b2NumFromFlxNum(-4.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-5.0),AEWorld.b2NumFromFlxNum(-24.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-1.0),AEWorld.b2NumFromFlxNum(-29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(3.0),AEWorld.b2NumFromFlxNum(-24.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(8.0),AEWorld.b2NumFromFlxNum(-4.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(8.0),AEWorld.b2NumFromFlxNum(22.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(3.0),AEWorld.b2NumFromFlxNum(29.0)));
		
		[Embed(source='../../res/Tail4.png')]
		private static const IMG:Class;
		
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(16,16,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(16,50, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);
		
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
