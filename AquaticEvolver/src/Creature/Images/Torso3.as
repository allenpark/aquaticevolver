package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Torso3 extends DefaultImage
	{
		
		private static const WIDTH:Number = 256;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */
		protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-57.0),AEWorld.b2NumFromFlxNum(40.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-64.0),AEWorld.b2NumFromFlxNum(33.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-58.0),AEWorld.b2NumFromFlxNum(-9.0)),
			//new b2Vec2(AEWorld.b2NumFromFlxNum(-51.0),AEWorld.b2NumFromFlxNum(-13.0)),
			//new b2Vec2(AEWorld.b2NumFromFlxNum(-43.0),AEWorld.b2NumFromFlxNum(-13.0)),
			//new b2Vec2(AEWorld.b2NumFromFlxNum(-34.0),AEWorld.b2NumFromFlxNum(-12.0)),
			//new b2Vec2(AEWorld.b2NumFromFlxNum(-26.0),AEWorld.b2NumFromFlxNum(-22.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-25.0),AEWorld.b2NumFromFlxNum(-31.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-8.0),AEWorld.b2NumFromFlxNum(-41.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(6.0),AEWorld.b2NumFromFlxNum(-41.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(20.0),AEWorld.b2NumFromFlxNum(-32.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(22.0),AEWorld.b2NumFromFlxNum(-19.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(31.0),AEWorld.b2NumFromFlxNum(-9.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(50.0),AEWorld.b2NumFromFlxNum(-11.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(59.0),AEWorld.b2NumFromFlxNum(0.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(63.0),AEWorld.b2NumFromFlxNum(29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(56.0),AEWorld.b2NumFromFlxNum(39.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(45.0),AEWorld.b2NumFromFlxNum(39.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(30.0),AEWorld.b2NumFromFlxNum(34.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(24.0),AEWorld.b2NumFromFlxNum(34.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(6.0),AEWorld.b2NumFromFlxNum(42.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-6.0),AEWorld.b2NumFromFlxNum(42.0)));
//			new b2Vec2(AEWorld.b2NumFromFlxNum(-21.0),AEWorld.b2NumFromFlxNum(35.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(-28.0),AEWorld.b2NumFromFlxNum(35.0)),
//			new b2Vec2(AEWorld.b2NumFromFlxNum(-44.0),AEWorld.b2NumFromFlxNum(40.0)));
		
		[Embed(source='../../res/Torso3.png')]
		private static const IMG:Class;
		
		protected static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(128,35,WIDTH,HEIGHT);
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(128,95,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(78,62, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot2:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(75,93, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot3:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(179,93, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot4:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(175,62, WIDTH, HEIGHT);
		
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
