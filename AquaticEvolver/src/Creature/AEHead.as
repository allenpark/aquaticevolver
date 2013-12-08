package Creature
{
	import Box2D.Common.Math.b2Vec2;
	
	import Def.AESegmentDef;

	public class AEHead
	{
		public var headSegment:AESegment;
		public var headAnchor:b2Vec2;
		
		public function AEHead(headSegmentDef:AESegmentDef, headAnchor:b2Vec2, creatureID:Number)
		{
			this.headSegment = headSegmentDef.createSegmentWithCreatureID(creatureID);
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
		
		public function color(color:Number):void
		{
			headSegment.color = color;
		}
	}
}