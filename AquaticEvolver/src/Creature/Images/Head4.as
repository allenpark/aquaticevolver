package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Head4 extends DefaultImage
	{
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */

		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-6.0),AEWorld.b2NumFromFlxNum(35.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-28.0),AEWorld.b2NumFromFlxNum(16.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-28.0),AEWorld.b2NumFromFlxNum(-1.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-23.0),AEWorld.b2NumFromFlxNum(-20.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-6.0),AEWorld.b2NumFromFlxNum(-38.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(0.0),AEWorld.b2NumFromFlxNum(-38.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(17.0),AEWorld.b2NumFromFlxNum(-21.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(25.0),AEWorld.b2NumFromFlxNum(-2.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(25.0),AEWorld.b2NumFromFlxNum(15.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(1.0),AEWorld.b2NumFromFlxNum(35.0)));

		
		[Embed(source='../../res/Head4.png')]
		private static const Img:Class;
			
		protected static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,93,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,40, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlots:Array = new Array(SuggestedAppendageSlot1);
		
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
