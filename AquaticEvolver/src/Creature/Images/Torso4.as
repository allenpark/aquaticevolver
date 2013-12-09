package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Torso4 extends DefaultImage
	{
		
		private static const WIDTH:Number = 64;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-5.0),AEWorld.b2NumFromFlxNum(45.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-23.0),AEWorld.b2NumFromFlxNum(33.0)),
			//new b2Vec2(AEWorld.b2NumFromFlxNum(-14.0),AEWorld.b2NumFromFlxNum(3.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-25.0),AEWorld.b2NumFromFlxNum(-29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-11.0),AEWorld.b2NumFromFlxNum(-45.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(11.0),AEWorld.b2NumFromFlxNum(-46.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(20.0),AEWorld.b2NumFromFlxNum(-31.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(21.0),AEWorld.b2NumFromFlxNum(-21.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(12.0),AEWorld.b2NumFromFlxNum(1.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(21.0),AEWorld.b2NumFromFlxNum(32.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(5.0),AEWorld.b2NumFromFlxNum(45.0)));
		
		[Embed(source='../../res/Torso4.png')]
		private static const IMG:Class;
		
		protected static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(32,27,WIDTH,HEIGHT);
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(32,100,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(17,38, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot2:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(19,90, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot3:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(45,90, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot4:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(47,38, WIDTH, HEIGHT);
		
		protected static const SuggestedAppendageSlots:Array = new Array(	
			SuggestedAppendageSlot1, 
			SuggestedAppendageSlot2, 
			SuggestedAppendageSlot3, 
			SuggestedAppendageSlot4);
		
		override public function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
		
		override public function suggestedHeadAnchor():b2Vec2
		{
			return SuggestedHeadAnchor;
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
