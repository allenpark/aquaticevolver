package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	public class Torso1 extends DefaultImage
	{
		
		private static const WIDTH:Number = 128;
		private static const HEIGHT:Number = 128;
		
		/**
		 * Vertices defining the verteces for the shape, have to offset them by half the width
		 * to assure that they are centered on the sprite
		 */

	protected static var PolygonVertices:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(0.0),AEWorld.b2NumFromFlxNum(46.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-6.0),AEWorld.b2NumFromFlxNum(46.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-15.0),AEWorld.b2NumFromFlxNum(43.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-25.0),AEWorld.b2NumFromFlxNum(34.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-34.0),AEWorld.b2NumFromFlxNum(26.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-38.0),AEWorld.b2NumFromFlxNum(17.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-42.0),AEWorld.b2NumFromFlxNum(6.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-42.0),AEWorld.b2NumFromFlxNum(-7.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-38.0),AEWorld.b2NumFromFlxNum(-19.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-32.0),AEWorld.b2NumFromFlxNum(-29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-24.0),AEWorld.b2NumFromFlxNum(-37.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-14.0),AEWorld.b2NumFromFlxNum(-43.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(1.0),AEWorld.b2NumFromFlxNum(-45.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(11.0),AEWorld.b2NumFromFlxNum(-44.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(24.0),AEWorld.b2NumFromFlxNum(-37.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(32.0),AEWorld.b2NumFromFlxNum(-29.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(39.0),AEWorld.b2NumFromFlxNum(-17.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(41.0),AEWorld.b2NumFromFlxNum(2.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(35.0),AEWorld.b2NumFromFlxNum(22.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(26.0),AEWorld.b2NumFromFlxNum(35.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(14.0),AEWorld.b2NumFromFlxNum(43.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(7.0),AEWorld.b2NumFromFlxNum(46.0)));


		[Embed(source='../../res/Torso1.png')]
		private static const IMG:Class;
		
		/*
		Torso1
		tail 64 98
		head 64 30
		attach1 43 46
		attach2 33 64
		attach3 46 89
		attach4 82 89
		attach5 95 64
		attach6 85 46
		*/
		
		protected static const SuggestedHeadAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,30,WIDTH,HEIGHT);
		protected static const SuggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(64,98,WIDTH,HEIGHT);
		
		protected static const SuggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(43,46, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot2:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(33,64, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot3:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(46,89, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot4:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(82,89, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot5:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(95,64, WIDTH, HEIGHT);
		protected static const SuggestedAppendageSlot6:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(85,46, WIDTH, HEIGHT);
		
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