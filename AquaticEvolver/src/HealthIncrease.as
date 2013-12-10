package
{	
	public class HealthIncrease extends Adaptation
	{
		import Creature.AECreature;
		
		public static const HEALTHINCREASEAMOUNT:int = 5;
		
		public function HealthIncrease(creature:AECreature)
		{
			super(10, false, null, creature, AdaptationType.HEALTHINCREASE);
			creature.maxHealth += HEALTHINCREASEAMOUNT;
			creature.currentHealth += HEALTHINCREASEAMOUNT;
		}
	}
}