package
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.*
	
	public class AECollisionListener extends b2ContactListener
	{
		/**
		 * Called when two fixtures begin to touch.
		 */
		override public function BeginContact(contact:b2Contact):void 
		{
			trace(contact);
			var fixture1:b2Fixture = contact.GetFixtureA();
			var fixture2:b2Fixture = contact.GetFixtureB();
			trace(fixture1.GetBody().GetUserData());
			trace(fixture2.GetBody().GetUserData());
		}
		
		/**
		 * Called when two fixtures cease to touch.
		 */
		override public function EndContact(contact:b2Contact):void 
		{
			
		}
	}
}