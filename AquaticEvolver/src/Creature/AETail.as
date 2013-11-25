package Creature
{
	import Box2D.Common.Math.b2Vec2;

	public class AETail
	{
		public var tailSegment:AESegment;
		public var tailAnchor:b2Vec2;
		
		public function AETail(tailSegment:AESegment, tailAnchor:b2Vec2)
		{
			this.tailSegment = tailSegment;
			this.tailAnchor = tailAnchor;
		}
		
		public static function addTailToWorld(tail:AETail, world:AEWorld):void
		{
			world.add(tail.tailSegment);
		}
		
		public function getAppendageSlots():Array
		{
			return tailSegment.appendageSlots;
		}
	}
}