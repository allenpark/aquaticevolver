package  
{
	import flash.display.Sprite;
	
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	public class DebugDraw extends Sprite
	{
		public function DebugDraw() 
		{
			super();
		}
		
		public function debugDrawSetup(Box2DWorld:b2World, MetersToPixelsRatio:Number, LineThickness:Number, Alpha:Number, FillAlpha:Number):void 
		{
			//addChild(debugSprite);
			
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			
			debugDraw.SetSprite(AquaticEvolver.DEBUG_SPRITE);
			debugDraw.SetDrawScale(MetersToPixelsRatio);
			debugDraw.SetLineThickness(LineThickness);
			debugDraw.SetAlpha(Alpha);
			debugDraw.SetFillAlpha(FillAlpha);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit | b2DebugDraw.e_centerOfMassBit | b2DebugDraw.e_aabbBit | b2DebugDraw.e_pairBit | b2DebugDraw.e_controllerBit);
			Box2DWorld.SetDebugDraw(debugDraw);
		}
	}
}