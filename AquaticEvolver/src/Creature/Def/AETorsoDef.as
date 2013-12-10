package Creature.Def
{
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.AETorso;

	public class AETorsoDef extends AEDefinition
	{
		protected var _headAnchor:b2Vec2;
		protected var _torsoSegmentDefs:Array;
		protected var _tailAnchor:b2Vec2;
		
		public function AETorsoDef(headAnchor:b2Vec2, torsoSegmentDefs:Array, tailAnchor:b2Vec2)
		{
			this._headAnchor = headAnchor;
			this._torsoSegmentDefs = torsoSegmentDefs;
			this._tailAnchor = tailAnchor;
			super();
		}
		
		public function createTorsoWithCreatureID(creatureID:Number):AETorso
		{
			return new AETorso(_headAnchor, _torsoSegmentDefs, _tailAnchor, creatureID);
		}
	}
}