package Creature
{
	import flash.utils.Dictionary;
	
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
		
	import Creature.Def.AESegmentDef;
	
	import org.flixel.FlxG;
	
	public class AESegment extends B2FlxSprite
	{	

		protected var _torsoSlots:Dictionary;
		public var appendageSlots:Array;
		
		protected var _spriteType:Number;
				
		/**
		 * The basic building block for creatures
		 * @param torsoSlots Dictionary mapping a torso slot label (string) to the local position of the torso slot (b2Vec2)
		 * @param adaptationSlots Array of b2Vec2 describing local position of adaptation slots
		 */
		
		/* OLD CONSTRUCTOR
		public function AESegment(x:Number, y:Number, schematic:AESchematic, shape:b2PolygonShape = null, creatureID:Number = 0)
		{
			super(x,y, 0, schematic.img(), schematic.width(), schematic.height(), shape, creatureID);
			_torsoSlots = schematic.torsoSlots();
			appendageSlots = generateSlotsFromLocations(schematic.appendageSlots());
		}
		*/
		
		public function AESegment(segmentDef:AESegmentDef, creatureID:Number)
		{
			//Pass in negative creatureID --> negative group filters means no collisions between members of that group
			//trace("Constructing segment with creature id:" +creatureID);
			super(segmentDef.x, segmentDef.y, 0, segmentDef.schematic.img(), segmentDef.schematic.width(), segmentDef.schematic.height(), segmentDef.shape, -creatureID);
			_torsoSlots = segmentDef.schematic.torsoSlots();
			appendageSlots = generateSlotsFromLocations(segmentDef.schematic.appendageSlots());
		}
		
		public function generateSlotsFromLocations(slotLocations:Array):Array
		{
			var slots:Array = new Array();
			for each (var location:b2Vec2 in slotLocations)
			{
				slots.push(new AESlot(this, location));
			}
			return slots;
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape=null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withFriction(0.8)
				.withRestitution(0.3)
				.withDensity(0.7)
				.withLinearDamping(3.0)
				.withAngularDamping(30.0)
			if(shape != null){
				//FlxG.log('Created with a different shape');
				b2bb.withShape(shape);
			}
			return b2bb;
		}
	}
}
