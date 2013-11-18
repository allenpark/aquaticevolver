package Creature
{
	import Box2D.Common.Math.b2Vec2;

	public class AETorso
	{
		public var headSegment:AESegment;
		public var torsoSegments:Array;
		public var tailSegment:AESegment;
		
		public var headAnchor:b2Vec2;
		public var tailAnchor:b2Vec2;
		
		public var adaptationSlots:Array;
		
		public function AETorso()
		{
		}
	}
}