package
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class AECollisionListener extends b2ContactListener
	{
		
		private function handlePlayerTentacleAttack(player:Boxplayer, enemy:BoxEnemy):void
		{
			trace("player attacked enemy");
			AEWorld.KILLLIST.push(enemy);
			//var pair:Array = new Array();
			//pair.push(player);
			//pair.push(enemy);
			//AEWorld.KILLLIST.push(pair);
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
			if (data1.owner.creatureType != SpriteType.ENEMY || data2.owner.creatureType != SpriteType.ENEMY) {
				AEWorld.debugStatement.text += " " + data1.owner.creatureType + "/" + data2.owner.creatureType;
			}
			if(data1.owner.creatureType == SpriteType.PLAYER && data2.owner.creatureType == SpriteType.ENEMY)
			{
				AEWorld.debugStatement.text += "/" + data1.colliderType;
				switch(data1.colliderType)
				{
					case SpriteType.TENTACLEHEAD:
						handlePlayerTentacleAttack((data1.owner as Boxplayer), (data2.owner as BoxEnemy));
						break;
					case SpriteType.SPIKE:
						handlePlayerTentacleAttack((data1.owner as Boxplayer), (data2.owner as BoxEnemy));
						break;
					default:
						trace("default collision");
						break;
				}	
			}
			if(data2.owner.creatureType == SpriteType.PLAYER && data1.owner.creatureType == SpriteType.ENEMY)
			{
				AEWorld.debugStatement.text += "/" + data2.colliderType;
				switch(data2.colliderType)
				{
					case SpriteType.TENTACLEHEAD:
						handlePlayerTentacleAttack((data2.owner as Boxplayer), (data1.owner as BoxEnemy));
						break;
					case SpriteType.SPIKE:
						handlePlayerTentacleAttack((data2.owner as Boxplayer), (data1.owner as BoxEnemy));
						break;
					default:
						trace("default collision");
						break;
				}	
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