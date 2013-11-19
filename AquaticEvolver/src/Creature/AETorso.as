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
				
		public var appendageSlots:Array;
		
		public function AETorso(headSegment, headAnchor, torsoSegments, tailSegment, tailAnchor)
		{
			this.headSegment = headSegment;
			this.headAnchor = headAnchor;
			this.torsoSegments = torsoSegments;
			this.tailSegment = tailSegment;
			this.tailAnchor = tailAnchor;
			
			initializeAppendageSlots();
		}
		
		private function initializeAppendageSlots():void
		{
			appendageSlots = new Array();
			for (var segment:AESegment in torsoSegments)
			{
				appendageSlots.concat(segment.appendageSlots);
			}
		}
	}
}