package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AEAttackDef
	{
		public var attacker:AECreature;
		public var victim:AECreature;
		
		public var attackType:Number;
		public var victimType:Number;
		
		public var attackB2FS:B2FlxSprite;
		public var victimB2FS:B2FlxSprite;
		
		public function AEAttackDef(attacker:AECreature, attackerType:Number, attackB2FS:B2FlxSprite, victim:AECreature, victimType:Number, victimB2FS:B2FlxSprite)
		{
			this.attacker = attacker;
			this.victim = victim;
			this.attackB2FS = attackB2FS;
			this.victimB2FS = victimB2FS;
		}
	}
}