package Creature.Def
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	
	import Creature.AESegment;
	import Creature.Schematics.AESchematic;

	public class AESegmentDef extends AEDefinition
	{
		public var x:Number;
		public var y:Number;
		public var schematic:AESchematic;
		public var shape:b2PolygonShape;
		
		public function AESegmentDef(x:Number, y:Number, schematic:AESchematic, shape:b2PolygonShape = null)
		{
			this.x = x;
			this.y = y;
			this.schematic = schematic;
			this.shape = shape;
			super();
		}
		
		public function createSegmentWithCreatureID(creatureID:Number):AESegment
		{
			return new AESegment(this, creatureID);
		}
	}
}