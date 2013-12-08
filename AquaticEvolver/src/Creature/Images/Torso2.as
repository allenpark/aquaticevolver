package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Torso2 extends DefaultImage
	{
		
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-11.0),AEWorld.b2NumFromFlxNum(47.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-23.0),AEWorld.b2NumFromFlxNum(40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-29.0),AEWorld.b2NumFromFlxNum(32.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-35.0),AEWorld.b2NumFromFlxNum(14.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-44.0),AEWorld.b2NumFromFlxNum(-7.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-47.0),AEWorld.b2NumFromFlxNum(-18.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-42.0),AEWorld.b2NumFromFlxNum(-40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-21.0),AEWorld.b2NumFromFlxNum(-48.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(22.0),AEWorld.b2NumFromFlxNum(-48.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(39.0),AEWorld.b2NumFromFlxNum(-39.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(45.0),AEWorld.b2NumFromFlxNum(-25.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(44.0),AEWorld.b2NumFromFlxNum(-9.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(35.0),AEWorld.b2NumFromFlxNum(12.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(31.0),AEWorld.b2NumFromFlxNum(31.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(26.0),AEWorld.b2NumFromFlxNum(40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(13.0),AEWorld.b2NumFromFlxNum(47.0)));
		
		[Embed(source='../../res/Torso2.png')]
		private static const IMG:Class;
		
		protected static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,28,WIDTH,HEIGHT);
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,100,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(30,32, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot2:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(35,66, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot3:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(47,95, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot4:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(81,95, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot5:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(93,66, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot6:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(98,32, WIDTH, HEIGHT);
		
		protected static const SuggestedAppendageSlots:Array = new Array(	
			SuggestedAppendageSlot1, 
			SuggestedAppendageSlot2, 
			SuggestedAppendageSlot3, 
			SuggestedAppendageSlot4, 
			SuggestedAppendageSlot5, 
			SuggestedAppendageSlot6);
		
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
