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
	import Creature.Schematics.AESchematic;
	
	public class AEPlayer extends AECreature
	{
		
		public function AEPlayer(x:Number, y:Number)
		{	
			var head:AEHead = playerHead(x,y);
			var torso:AETorso = playerTorso(x,y);
			var tail:AETail = playerTail(x,y);
			super(SpriteType.PLAYER, x, y, head, torso, tail);
		}
		
		public function getFollowObject():B2FlxSprite
		{
			return _head.headSegment;
		}
		
		private function playerHead(x:Number, y:Number):AEHead
		{
			var headSchematic:AESchematic = new AESchematic(Head1.image(), Head1.suggestedAppendageSlots);
			var playerHeadSegment:AESegment = new AESegment(x,y, headSchematic);
			var playerHead:AEHead = new AEHead(playerHeadSegment, Head1.suggestedHeadAnchor);
			return playerHead;
		}
		
		private function playerTorso(x:Number, y:Number):AETorso
		{
			var torsoSchematic:AESchematic = new AESchematic(Torso1.image(), Torso1.suggestedAppendageSlots);
			var playerTorsoSegment:AESegment = new AESegment(x,y, torsoSchematic);
			var playerTorsoSegments:Array = new Array(playerTorsoSegment);
			var playerTorso:AETorso = new AETorso(playerTorsoSegment, Torso1.suggestedHeadAnchor, playerTorsoSegments, playerTorsoSegment, Torso1.suggestedTailAnchor);
			return playerTorso;
		}
		
		private function playerTail(x:Number, y:Number):AETail
		{
			var tailSchematic:AESchematic = new AESchematic(Tail1.image(), Tail1.suggestedAppendageSlots);
			var playerTailSegment:AESegment = new AESegment(x, y, tailSchematic);
			var playerTail:AETail = new AETail(playerTailSegment, Tail1.suggestedTailAnchor);
			return playerTail;
		}	
	}
}