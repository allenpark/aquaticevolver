package
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	
	import Creature.AECreature;
	
	public class AECollisionListener extends b2ContactListener
	{
		
		private function handleAttack(attackerData:CollisionData, enemyData:CollisionData):void
		{
			trace("player attacked enemy");
			trace(attackerData);
			trace(enemyData);
			var attackDescription:Array = new Array();
			attackDescription.push(attackerData.owner);
			attackDescription.push(enemyData.owner);
			attackDescription.push(attackerData.adaptation);
			AEWorld.KILLLIST.push(attackDescription);
		}
		
		private function handleEvolution(creatureData:CollisionData, evolutionData:CollisionData):void
		{
			//Add adaptation to player
			trace("Evolution Collision");
			trace(creatureData.owner);
			trace(AdaptationType.TENTACLE);
			var evolveDescription:Array = new Array();
			evolveDescription.push(creatureData.owner as AECreature);
			evolveDescription.push(AdaptationType.TENTACLE);
			AEWorld.EVOLVELIST.push(evolveDescription);
			
			
			//Kill evolution drop
			AEWorld.REMOVELIST.push(evolutionData.owner as EvolutionDrop);
			
			
		}
		
		/**
		 * Called when two fixtures begin to touch.
		 */
		override public function BeginContact(contact:b2Contact):void 
		{
			//trace("DEBUG: Collision handler - " + contact);
			var fixture1:b2Fixture = contact.GetFixtureA();
			var fixture2:b2Fixture = contact.GetFixtureB();
			var data1:CollisionData = (fixture1.GetBody().GetUserData() as CollisionData);
			var data2:CollisionData = (fixture2.GetBody().GetUserData() as CollisionData);
			trace(data1.owner + " " + data1.colliderType + " " + data1.adaptation);
			trace(data2.owner + " " + data2.colliderType + " " + data2.adaptation);
			
			if (data1.owner.getID() == data2.owner.getID()) {
				return;
			}
			
			//if (data1.owner.creatureType == SpriteType.PLAYER && data2.owner.creatureType == SpriteType.ENEMY)
			if (data1.owner.creatureType != data1.colliderType && data2.owner.creatureType == data2.colliderType) {
				// data1 is an adaptation and data2 is a body.
				if (data2.owner.creatureType == SpriteType.EVOLUTIONDROP)
				{
					handleEvolution(data1, data2);
				}
				else
				{
					handleAttack(data1, data2);	
				}
			} else if (data1.owner.creatureType == data1.colliderType && data2.owner.creatureType != data2.colliderType) {
				// data1 is a body and data2 is an adaptation.
				if (data1.owner.creatureType == SpriteType.EVOLUTIONDROP)
				{
					handleEvolution(data2, data1);
				}
				else
				{
					handleAttack(data2, data1);	
				}
			} // else do not register the attack
			else if ((data1.owner.creatureType == SpriteType.PLAYER || data1.owner.creatureType == SpriteType.ENEMY) && data2.owner.creatureType == SpriteType.EVOLUTIONDROP) {
				handleEvolution(data1, data2);
			}
			else if (data1.owner.creatureType == SpriteType.EVOLUTIONDROP && (data1.owner.creatureType == SpriteType.PLAYER || data1.owner.creatureType == SpriteType.ENEMY)) {
				handleEvolution(data2, data1);
			}
		}
		
		/**
		 * Called when two fixtures cease to touch.
		 */
		override public function EndContact(contact:b2Contact):void 
		{
			
		}
	}
}
