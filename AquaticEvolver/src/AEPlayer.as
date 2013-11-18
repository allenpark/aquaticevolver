package
{
	import Creature.AECreature;
	import Creature.AEHead;
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
			var head:AEHead = new AEHead(); //Pass in image
			var torso:AETorso = new AETorso(); //Pass in image
			var tail:AETail = new AETail(); //Pass in image
			super(x, y, head, torso, tail);
		}
	}
}