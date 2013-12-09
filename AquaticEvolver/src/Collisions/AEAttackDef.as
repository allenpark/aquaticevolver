package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AEAttackDef
	{
		public var attacker:AECreature;
		public var victim:AECreature;
		
		public var attackerB2FS:B2FlxSprite;
		public var victimB2FS:B2FlxSprite;
		
		public function AEAttackDef(attacker:AECreature, victim:AECreature, attackerB2FS:B2FlxSprite, victimB2FS:B2FlxSprite)
		{
			this.attacker = attacker;
			this.victim = victim;
			this.attackerB2FS = attackerB2FS;
			this.victimB2FS = victimB2FS;
		}
	}
}