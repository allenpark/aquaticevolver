package
{
	public class SpeedIncrease extends Adaptation
	{
		import Creature.AECreature;
		
		public static const SPEEDINCREASEAMOUNT:int = 2;
		
		public function SpeedIncrease(creature:AECreature)
		{
			super(10, false, null, creature, AdaptationType.SPEEDINCREASE);
			creature.speed += SPEEDINCREASEAMOUNT;
		}
	}
}