package Collisions
{
	import Creature.AECreature;

	public class AEEvolutionDef
	{
		public var creature:AECreature;
		public var evolutionDrop:EvolutionDrop;
		
		public function AEEvolutionDef(creature:AECreature, evolutionDrop:EvolutionDrop)
		{
			this.creature = creature;
			this.evolutionDrop = evolutionDrop;
		}
	}
}