package Creature.Def
{
	import Box2D.Common.Math.b2Vec2;
	import Creature.AETail;
	
	public class AETailDef extends AEDefinition
	{
		protected var _tailSegmentDef:AESegmentDef;
		protected var _tailAnchor:b2Vec2;
		
		public function AETailDef(tailSegmentDef:AESegmentDef, tailAnchor:b2Vec2)
		{
			_tailSegmentDef = tailSegmentDef;
			_tailAnchor = tailAnchor;
			super();
		}
		
		public function createTailWithCreatureID(creatureID:Number):AETail
		{
			return new AETail(_tailSegmentDef, _tailAnchor, creatureID);
		}
	}
}