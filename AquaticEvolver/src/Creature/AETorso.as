package Creature
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	public class AETorso
	{
		public var headSegment:b2Body;
		public var tailSegment:b2Body;
		
		public var headAnchor:b2Vec2;
		public var tailAnchor:b2Vec2;
		
		public function AETorso()
		{
		}
	}
}