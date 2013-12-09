package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AEAttackDef
	{
		public var attackerBody:b2Body;
		public var victimBody:b2Body;
		
		public function AEAttackDef(attacker:AECreature, victim:AECreature, attackerBody:b2Body, victimBody:b2Body)
		{
			
		}
	}
}