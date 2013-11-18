package Creature
{
	import Box2D.Common.Math.b2Vec2;

	public class AEHead
	{
		public var headSegment:AESegment;
		public var headAnchor:b2Vec2;
		
		public function AEHead(headSegment:AESegment, headAnchor:b2Vec2)
		{
			this.headSegment = headSegment;
			this.headAnchor = headAnchor;
		}
	}
}