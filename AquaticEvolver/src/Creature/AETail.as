package Creature
{
	import Box2D.Common.Math.b2Vec2;
	
	import Collisions.AECollisionData;
	
	import Def.AESegmentDef;

	public class AETail
	{
		public var tailSegment:AESegment;
		public var tailAnchor:b2Vec2;
		
		public function AETail(tailSegmentDef:AESegmentDef, tailAnchor:b2Vec2, creatureID:Number)
		{
			this.tailSegment = tailSegmentDef.createSegmentWithCreatureID(creatureID);
			this.tailAnchor = tailAnchor;
		}
		
		public function ownBodies(creature:AECreature):void 
		{
			tailSegment.getBody().SetUserData(new AECollisionData(SpriteType.CREATURE, tailSegment, null, creature));
		}
		
		public function addToWorld():void
		{
			AEWorld.world.add(tailSegment);
		}
		
		public function getAppendageSlots():Array
		{
			return tailSegment.appendageSlots;
		}
		
		public function kill():void
		{
			tailSegment.kill();
		}
		
		public function color(color:Number):void
		{
			tailSegment.color = color;
		}
	}
}