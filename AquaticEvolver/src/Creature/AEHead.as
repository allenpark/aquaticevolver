package Creature
{
	import Box2D.Common.Math.b2Vec2;

	public class AEHead
	{
		public var headSegment:AESegment;
		public var headAnchor:b2Vec2;
		
		public function AEHead(headSegment:AESegment, headAnchor:b2Vec2)
		{
			this.headSegment = headSegment;
			this.headAnchor = headAnchor;
		}
		
		public function ownBodies(owner:*, type:Number):void
		{
			headSegment.getBody().SetUserData(new CollisionData(owner, type));
		}
		
		public function addToWorld():void
		{
			AEWorld.world.add(headSegment);
		}
		
		public function getAppendageSlots():Array
		{
			return headSegment.appendageSlots;
		}
		
		public function kill():void
		{
			headSegment.kill();
		}
	}
}