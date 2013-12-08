package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;

	public class DefaultImage
	{
		public function DefaultImage()
		{
		}
		
		public function image():AEImage
		{
			return null;
		}
		
		public function suggestedHeadAnchor():b2Vec2
		{
			return null;
		}
		
		public function suggestedTailAnchor():b2Vec2
		{
			return null;
		}
		
		public function suggestedAppendageSlots():Array
		{
			return null;
		}
		
		public function polygonVertices():Array
		{
			return null;
		}
	}
}