package Creature
{	
	import Box2D.Common.Math.b2Vec2;
	
	import Def.AESegmentDef;
	import Def.AETorsoDef;
	
	public class AETorso
	{
		public var headSegment:AESegment;
		public var torsoSegments:Array;
		public var tailSegment:AESegment;
		
		public var headAnchor:b2Vec2;
		public var tailAnchor:b2Vec2;
				
		private var _appendageSlots:Array;
		
		/**
		 * IMPORTANT: An AETorso object requires that the headSegment, torsoSegments, and tailSegment be connected by joints BEFORE this constructor is called!
		 */
		/*
		public function AETorso(headSegment, headAnchor, torsoSegments, tailSegment, tailAnchor)
		{
			this.headSegment = headSegment;
			this.headAnchor = headAnchor;
			this.torsoSegments = torsoSegments;
			this.tailSegment = tailSegment;
			this.tailAnchor = tailAnchor;
			
			trace("Torso segments: " + torsoSegments);
			
			initializeAppendageSlots();
		}
		*/
		public function AETorso(headAnchor:b2Vec2, torsoSegmentDefs:Array, tailAnchor:b2Vec2, creatureID:Number)
		{
			this.headAnchor = headAnchor;
			this.tailAnchor = tailAnchor;
					
			initializeHeadTorsoTailSegmentsWithCreatureID(torsoSegmentDefs, creatureID);
			
			initializeAppendageSlots();
		}
		
		public function initializeHeadTorsoTailSegmentsWithCreatureID(torsoSegmentDefs:Array, creatureID:Number):void
		{
			this.torsoSegments = new Array();
			
			for (var i:Number=0; i < torsoSegmentDefs.length; i++)
			{
				var torsoSegmentDef:AESegmentDef = torsoSegmentDefs[i];
				var torsoSegment:AESegment = torsoSegmentDef.createSegmentWithCreatureID(creatureID);
				if (i == 0)
				{
					headSegment = torsoSegment;
				}
				if (i == torsoSegmentDefs.length - 1)
				{
					tailSegment = torsoSegment;
				}
				torsoSegments.push(torsoSegment);
			}
		}
		
		public function ownBodies(owner:*, type:Number):void
		{
			for each (var torsoSegment:AESegment in torsoSegments)
			{
				torsoSegment.getBody().SetUserData(new CollisionData(owner, type));
			}
		}
		
		public function addToWorld():void
		{
			for each (var torsoSegment:AESegment in torsoSegments)
			{
				AEWorld.world.add(torsoSegment);
			}
		}
		
		public function initializeAppendageSlots():void
		{
			_appendageSlots = new Array();
			for each (var segment:AESegment in torsoSegments)
			{
				_appendageSlots = _appendageSlots.concat(segment.appendageSlots);
			}
		}
		
		public function getAppendageSlots():Array
		{
			return _appendageSlots;
		}
		
		public function kill():void
		{
			for each (var segment:AESegment in torsoSegments)
			{
				segment.kill();
			}
		}
		
		public function color(color:Number):void
		{
			for each (var segment:AESegment in torsoSegments) {
				segment.color = color;
			}
		}
	}
}