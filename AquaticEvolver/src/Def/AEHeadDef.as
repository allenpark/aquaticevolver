package Def
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.AEHead;
	
	public class AEHeadDef extends AEDefinition
	{
		protected var _headSegmentDef:AESegmentDef;
		protected var _headAnchor:b2Vec2;
		
		public function AEHeadDef(headSegmentDef:AESegmentDef, headAnchor:b2Vec2)
		{
			this._headSegmentDef = headSegmentDef;
			this._headAnchor = headAnchor;
			super();
		}
		
		public function createHeadWithCreatureID(creatureID:Number):AEHead
		{
			return new AEHead(_headSegmentDef, _headAnchor, creatureID);
		}
	}
}