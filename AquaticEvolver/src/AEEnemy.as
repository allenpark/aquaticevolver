package
{
	import Creature.AECreature;
	import Creature.AEHead;
	import Creature.AETail;
	import Creature.AETorso;
	
	public class AEEnemy extends AECreature
	{
		public function AEEnemy(type:Number, x:Number, y:Number, head:AEHead, torso:AETorso, tail:AETail)
		{
			super(type, x, y, head, torso, tail);
		}
	}
}