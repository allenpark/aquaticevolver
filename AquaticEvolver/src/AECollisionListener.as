package
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class AECollisionListener extends b2ContactListener
	{
		
		private function handleAttack(attackerData:CollisionData, enemyData:CollisionData):void
		{
			trace("player attacked enemy");
			var attackDescription:Array = new Array();
			attackDescription.push(attackerData.owner);
			attackDescription.push(enemyData.owner);
			attackDescription.push(attackerData.adaptation);
			AEWorld.KILLLIST.push(attackDescription);
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
			
			if (data1.owner.creatureType == data2.owner.creatureType) {
				return;
			}
			
			//if (data1.owner.creatureType == SpriteType.PLAYER && data2.owner.creatureType == SpriteType.ENEMY)
			if (data1.owner.creatureType != data1.colliderType && data2.owner.creatureType == data2.colliderType) {
				// data1 is an adaptation and data2 is a body.
				handleAttack(data1, data2);
			} else if (data1.owner.creatureType == data1.colliderType && data2.owner.creatureType != data2.colliderType) {
				// data1 is a body and data2 is an adaptation.
				handleAttack(data2, data1);
			} // else do not register the attack
		}
		
		/**
		 * Called when two fixtures cease to touch.
		 */
		override public function EndContact(contact:b2Contact):void 
		{
			
		}
	}
}