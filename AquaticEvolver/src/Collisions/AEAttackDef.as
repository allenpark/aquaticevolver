package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AEAttackDef
	{
		public var attacker:AECreature;
		public var victim:AECreature;

		public var attackType:Number;
		public var attackB2FS:B2FlxSprite;
		public var attackAppendage:Appendage;
		
		public function AEAttackDef(attacker:AECreature, attackType:Number, attackB2FS:B2FlxSprite, attackAppendage:Appendage, victim:AECreature)
		{
			this.attacker = attacker;
			this.attackType = attackType;
			this.attackB2FS = attackB2FS;
			this.attackAppendage = attackAppendage;
			this.victim = victim;
		}
	}
}