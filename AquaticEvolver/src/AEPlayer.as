package
{
	import Creature.AECreature;
	import Creature.AEHead;
	import Creature.AESegment;
	import Creature.AETail;
	import Creature.AETorso;
	
	public class AEPlayer extends AECreature
	{
		[Embed(source='res/Head1.png')]
		private static var headSegmentImg:Class;
		
		[Embed(source='res/Torso1.png')]
		private static var torsoSegmentImg:Class;
		
		[Embed(source='res/Tail1.png')]
		private static var tailSegmentImg:Class;
		
		public function AEPlayer(x:Number, y:Number)
		{	
			var head:AEHead = playerHead(x,y);
			var torso:AETorso = playerTorso(x,y);
			var tail:AETail = playerTail(x,y);
			super(x, y, head, torso, tail);
		}
		
		private function playerHead(x:Number, y:Number):AEHead
		{
			var playerHeadSegment:AESegment = new AESegment(x,y,headSegmentImg, 128, 128);
			var playerHead:AEHead = new AEHead(playerHeadSegment, null);
			return playerHead;
		}
		
		private function playerTorso(x:Number, y:Number):AETorso
		{
			var playerTorsoSegment:AESegment = new AESegment(x,y, torsoSegmentImg, 128, 128);
			var playerTorsoSegments:Array = new Array(playerTorsoSegment);
			var playerTorso:AETorso = new AETorso(playerTorsoSegment, null, playerTorsoSegments, playerTorsoSegment, null);
			return AETorso;
		}
		
		private function playerTail(x:Number, y:Number):AETail
		{
			var playerTailSegment:AESegment = new AESegment(x, y, tailSegmentImg, 64, 64);
			var playerTail:AETail = new AETail(playerTailSegment, null);
			return playerTail;
		}	
	}
}