package Collisions
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class AECollisionListener extends b2ContactListener
	{
		protected static const DAMAGE_DEALING_SPRITES:Array = new Array(
			SpriteType.BUBBLE,
			SpriteType.MANDIBLEJAW,
			SpriteType.SPIKE,
			SpriteType.SPIKEBULLET,
			SpriteType.TENTACLEHEAD);
		
		protected static const DAMAGE_TAKING_SPRITES:Array = new Array(
			SpriteType.CREATURE,
			SpriteType.BUBBLEGUN,
			SpriteType.MANDIBLEBASE,
			SpriteType.POISONCANNON,
			SpriteType.SPIKESHOOTER,
			SpriteType.TENTACLEMID);
		
		protected static const PROJECTILES:Array = new Array(
			SpriteType.BUBBLE,
			SpriteType.SPIKEBULLET);
		
		
		private function elemInArray(element:*, array:Array):Boolean
		{
			return array.indexOf(element) != -1;
		}
		
		
		private static function handleAttack(attackerData:AECollisionData, victimData:AECollisionData):void
		{
			var attackDef:AEAttackDef = new AEAttackDef(attackerData.creature, attackerData.spriteType, attackerData.b2FlxSprite, attackerData.appendage, victimData.creature);
			AEWorld.AttackList.push(attackDef);
		}
		
		private static function handleEvolution(creatureData:AECollisionData, evolutionData:AECollisionData):void
		{			
			// Evolve player with evolution drop
			var evolutionDrop:EvolutionDrop = (evolutionData.b2FlxSprite as EvolutionDrop);
			var evolutionDef:AEEvolutionDef = new AEEvolutionDef(creatureData.creature, evolutionDrop);
			AEWorld.EvolveList.push(evolutionDef);
			
			//Kill evolution drop
			AEWorld.RemoveList.push(evolutionDrop);
		}
		
		private static function handleHealthRegen(creatureData:AECollisionData, healthData:AECollisionData):void
		{
			var healthDrop:HealthDrop = (healthData.b2FlxSprite as HealthDrop);
			var healthDef:AEHealthDef = new AEHealthDef(creatureData.creature, healthDrop);
			AEWorld.HealthList.push(healthDef);
			
			//Kill health drop	
			AEWorld.RemoveList.push(healthDrop);
		}
		
		/**
		 * Called when two fixtures begin to touch.
		 */
		override public function BeginContact(contact:b2Contact):void 
		{
			/*
			//Deal damage
			TENTACLEHEAD = 7
			SPIKE = 4
			MANDIBLEJAW = 9
			BUBBLE = 50
			
			//Take damage
			TENTACLEMID = 6
			MANDIBLEBASE = 10
			BUBBLEGUN = 11
			SPIKESHOOTER = 14
			(POISONCANNON = 13)
			head-torso-tail
			
			//trigger evolution
			EVOLUTIONDROP = 60
			
			//Don't take damage
			SHELL = 12
			*/			
			var fixture1:b2Fixture = contact.GetFixtureA();
			var fixture2:b2Fixture = contact.GetFixtureB();
			var data1:AECollisionData = (fixture1.GetBody().GetUserData() as AECollisionData);
			var data2:AECollisionData = (fixture2.GetBody().GetUserData() as AECollisionData);
			if (data1.creature && data2.creature){
				if (data1.creature.getID() == data2.creature.getID()) 
				{
					// Creature hit itself
					return;
				}
			}
			
			if (elemInArray(data1.spriteType, DAMAGE_DEALING_SPRITES) && elemInArray(data2.spriteType, DAMAGE_TAKING_SPRITES))
			{
				// data1 deals damage to data2
				AECollisionListener.handleAttack(data1, data2);
				if (elemInArray(data1.spriteType, PROJECTILES))
				{
					//trace("sprite should be killed!:" + data1.spriteType);
					AEWorld.RemoveList.push(data1.b2FlxSprite);
				}
				else
				{
					//trace(data1.spriteType+" spriteType should not be a projectile");
				}
				return
				
			}
			else if (elemInArray(data1.spriteType, DAMAGE_TAKING_SPRITES) && elemInArray(data2.spriteType, DAMAGE_DEALING_SPRITES))
			{
				// data2 deals damage to data1
				AECollisionListener.handleAttack(data2, data1);
				if (elemInArray(data2.spriteType, PROJECTILES))
				{
					//trace("sprite should be killed!:" + data2.spriteType);
					AEWorld.RemoveList.push(data2.b2FlxSprite);
				}
				else
				{
					//trace(data2.spriteType+" spriteType should not be a projectile");

				}
				return
				
			}
			else if (data1.creature && (data2.spriteType == SpriteType.EVOLUTIONDROP))
			{
				// trigger evolution of data1 with data2
				AECollisionListener.handleEvolution(data1, data2);
				return;
			}
			else if ((data1.spriteType == SpriteType.EVOLUTIONDROP) && data2.creature) 
			{
				// trigger evolution of data2 with data1
				AECollisionListener.handleEvolution(data2, data1);
				return;
			}
			else if (data1.creature && (data2.spriteType == SpriteType.HEALTHDROP))
			{
				// trigger evolution of data1 with data2
				AECollisionListener.handleHealthRegen(data1, data2);
				return;
			}
			else if ((data1.spriteType == SpriteType.HEALTHDROP) && data2.creature) 
			{
				// trigger evolution of data2 with data1
				AECollisionListener.handleHealthRegen(data2, data1);
				return;
			}
			return;
			//  By not handling shell collisions, we don't deal damage		
			
			/*
			
			*** OLD IMPLEMENTATION ***
			
			//if (data1.owner.creatureType == SpriteType.PLAYER && data2.owner.creatureType == SpriteType.ENEMY)
			if (data1.creature.creatureType != data1.colliderType && data2.creature.creatureType == data2.colliderType) {
			// data1 is an adaptation and data2 is a body.
			if (data2.creature.creatureType == SpriteType.EVOLUTIONDROP)
			{
			handleEvolution(data1, data2);
			}
			else
			{
			handleAttack(data1, data2);	
			}
			} else if (data1.creature.creatureType == data1.colliderType && data2.creature.creatureType != data2.colliderType) {
			// data1 is a body and data2 is an adaptation.
			if (data1.creature.creatureType == SpriteType.EVOLUTIONDROP)
			{
			handleEvolution(data2, data1);
			}
			else
			{
			handleAttack(data2, data1);	
			}
			} // else do not register the attack
			else if ((data1.creature.creatureType == SpriteType.PLAYER || data1.creature.creatureType == SpriteType.ENEMY) && data2.creature.creatureType == SpriteType.EVOLUTIONDROP) {
			handleEvolution(data1, data2);
			}
			else if (data1.creature.creatureType == SpriteType.EVOLUTIONDROP && (data1.creature.creatureType == SpriteType.PLAYER || data1.creature.creatureType == SpriteType.ENEMY)) {
			handleEvolution(data2, data1);
			}
			*/
		}
		
		/**
		 * Called when two fixtures cease to touch.
		 */
		override public function EndContact(contact:b2Contact):void 
		{
			
		}
	}
}
