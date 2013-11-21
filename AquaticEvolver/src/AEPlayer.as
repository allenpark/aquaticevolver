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
			var torso:AETorso = playerTorso();
			var tail:AETail = playerTail();
			super(x, y, head, torso, tail);
		}
		
		private function playerHead(x:Number, y:Number):AEHead
		{
			var playerHeadSegment:AESegment = new AESegment(x,y,headSegmentImg, 128, 128);
			var playerHead:AEHead = new new AEHead(playerHeadSegment, null);
			return null;
		}
		
		private function playerTorso():AETorso
		{
			return null;
		}
		
		private function playerTail():AETail
		{
			return null;
		}	
	}
}