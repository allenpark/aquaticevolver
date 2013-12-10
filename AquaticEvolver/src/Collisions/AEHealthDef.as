package Collisions
{
	import Creature.AECreature;
	
	public class AEHealthDef
	{
		public var creature:AECreature;
		public var healthDrop:HealthDrop;
		
		public function AEHealthDef(creature:AECreature, healthDrop:HealthDrop)
		{
			this.creature = creature;
			this.healthDrop = healthDrop;
		}
	}
}