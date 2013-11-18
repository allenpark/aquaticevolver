package
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.b2ContactListener;
	
	public class AECollisionListener extends b2ContactListener
	{
		
		private function handlePlayerTentacleAttack(player:Boxplayer, enemy:BoxEnemy):void
		{
			trace("player attacked enemy");
			AEWorld.KILLLIST.push(enemy);
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
			if(data1.owner.creatureType == SpriteType.PLAYER && data2.owner.creatureType == SpriteType.ENEMY)
			{
				switch(data1.colliderType)
				{
					case SpriteType.TENTACLEHEAD:
						handlePlayerTentacleAttack((data1.owner as Boxplayer), (data2.owner as BoxEnemy));
						break;
					default:
						trace("default collision");
						break;
				}	
			}
			if(data2.owner.creatureType == SpriteType.PLAYER && data1.owner.creatureType == SpriteType.ENEMY)
			{
				switch(data1.colliderType)
				{
					case SpriteType.TENTACLEHEAD:
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