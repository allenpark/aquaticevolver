package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;

	public class Tail1 extends DefaultImage
	{
				
		private static const WIDTH:Number = 64;
		private static const HEIGHT:Number = 64;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */

		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(4),AEWorld.b2NumFromFlxNum(27)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-1),AEWorld.b2NumFromFlxNum(27)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-11),AEWorld.b2NumFromFlxNum(13)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-17),AEWorld.b2NumFromFlxNum(-2)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-17),AEWorld.b2NumFromFlxNum(-12)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-11),AEWorld.b2NumFromFlxNum(-20)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-3),AEWorld.b2NumFromFlxNum(-25)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(4),AEWorld.b2NumFromFlxNum(-25)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(12),AEWorld.b2NumFromFlxNum(-19)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(16),AEWorld.b2NumFromFlxNum(-11)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(16),AEWorld.b2NumFromFlxNum(0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(12),AEWorld.b2NumFromFlxNum(12)));

		
		[Embed(source='../../res/Tail1.png')]
		private static const IMG:Class;
		
		public static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(32,16,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(32,45, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);

		override public function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
		
		override public function suggestedTailAnchor():b2Vec2
		{
			return SuggestedTailAnchor;
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