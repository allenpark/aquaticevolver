package
{
	import Creature.AECreature;
	import Creature.AEHead;
	import Creature.AESegment;
	import Creature.AETail;
	import Creature.AETorso;
	import Creature.Images.Head1;
	import Creature.Images.Tail1;
	import Creature.Images.Torso1;
	
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
			var headSchematic:Head1 = new Head1(Head1.headAnchor, Head1.potentialSlots);
			var playerHeadSegment:AESegment = new AESegment(x,y, headSchematic);
			var playerHead:AEHead = new AEHead(playerHeadSegment, headSchematic.headAnchor());
			return playerHead;
		}
		
		private function playerTorso(x:Number, y:Number):AETorso
		{
			var torsoSchematic:Torso1 = new Torso1(Torso1.potentialSlots, null, Torso1.potentialHeadAnchor, Torso1.potentialTailAnchor);
			var playerTorsoSegment:AESegment = new AESegment(x,y, torsoSchematic);
			var playerTorsoSegments:Array = new Array(playerTorsoSegment);
			var playerTorso:AETorso = new AETorso(playerTorsoSegment, torsoSchematic.headAnchor(), playerTorsoSegments, playerTorsoSegment, torsoSchematic.tailAnchor());
			return AETorso;
		}
		
		private function playerTail(x:Number, y:Number):AETail
		{
			var tailSchematic:Tail1 = new Tail1(Tail1.tailAnchor, Tail1.potentialSlots);
			var playerTailSegment:AESegment = new AESegment(x, y, tailSchematic);
			var playerTail:AETail = new AETail(playerTailSegment, tailSchematic.tailAnchor());
			return playerTail;
		}	
	}
}