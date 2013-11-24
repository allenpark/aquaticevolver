package
{
	import Creature.AECreature;
	import Creature.AEHead;
	import Creature.AESegment;
	import Creature.AETail;
	import Creature.AETorso;
	import Creature.CreatureSchematics.Head1;
	import Creature.CreatureSchematics.Tail1;
	import Creature.CreatureSchematics.Torso1;
	
	public class AEPlayer extends AECreature
	{
		
		public function AEPlayer(x:Number, y:Number)
		{	
			var head:AEHead = playerHead(x,y);
			var torso:AETorso = playerTorso(x,y);
			var tail:AETail = playerTail(x,y);
			super(x, y, head, torso, tail);
		}
		
		private function playerHead(x:Number, y:Number):AEHead
		{
			var playerHeadSegment:AESegment = new AESegment(x,y,new Head1());
			var playerHead:AEHead = new AEHead(playerHeadSegment, null);
			return playerHead;
		}
		
		private function playerTorso(x:Number, y:Number):AETorso
		{
			var playerTorsoSegment:AESegment = new AESegment(x,y, new Torso1());
			var playerTorsoSegments:Array = new Array(playerTorsoSegment);
			var playerTorso:AETorso = new AETorso(playerTorsoSegment, null, playerTorsoSegments, playerTorsoSegment, null);
			return AETorso;
		}
		
		private function playerTail(x:Number, y:Number):AETail
		{
			var playerTailSegment:AESegment = new AESegment(x, y, new Tail1());
			var playerTail:AETail = new AETail(playerTailSegment, null);
			return playerTail;
		}	
	}
}