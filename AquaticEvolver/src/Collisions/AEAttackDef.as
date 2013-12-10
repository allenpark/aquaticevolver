package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AEAttackDef
	{
		public var attacker:AECreature;
		public var victim:AECreature;

		public var attackAppendage:Appendage;
		
		public function AEAttackDef(attacker:AECreature, attackAppendage:Appendage, victim:AECreature)
		{
			this.attacker = attacker;
			this.attackAppendage = attackAppendage;
			this.victim = victim;
		}
	}
}