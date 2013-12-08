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
		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-3.0),AEWorld.b2NumFromFlxNum(40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-19.0),AEWorld.b2NumFromFlxNum(12.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-41.0),AEWorld.b2NumFromFlxNum(-4.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-41.0),AEWorld.b2NumFromFlxNum(-12.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-20.0),AEWorld.b2NumFromFlxNum(-26.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-7.0),AEWorld.b2NumFromFlxNum(-40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(6.0),AEWorld.b2NumFromFlxNum(-40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(18.0),AEWorld.b2NumFromFlxNum(-27.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(39.0),AEWorld.b2NumFromFlxNum(-13.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(39.0),AEWorld.b2NumFromFlxNum(-4.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(20.0),AEWorld.b2NumFromFlxNum(11.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(2.0),AEWorld.b2NumFromFlxNum(40.0)));
		
		[Embed(source='../../res/Tail3.png')]
		private static const IMG:Class;
		
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,36,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,90, WIDTH, HEIGHT);
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
