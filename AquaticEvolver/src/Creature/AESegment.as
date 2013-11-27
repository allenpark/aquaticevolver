package Creature
{
	import flash.utils.Dictionary;
	
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.Schematics.AESchematic;
	
	import org.flixel.FlxG;
	
	public class AESegment extends B2FlxSprite
	{	

		protected var _torsoSlots:Dictionary;
		public var appendageSlots:Array;
		
		/**
		 * The basic building block for creatures
		 * @param torsoSlots Dictionary mapping a torso slot label (string) to the local position of the torso slot (b2Vec2)
		 * @param adaptationSlots Array of b2Vec2 describing local position of adaptation slots
		 */
		/*
		public function AESegment(x:Number, y:Number, Graphic:Class=null, width:Number=0, height:Number=0, torsoSlots:Dictionary=null, appendageSlotLocations:Array=null)
		{
			super(x, y, Graphic, width, height);
			_torsoSlots = torsoSlots;
			this.appendageSlots = generateSlotsFromLocations(appendageSlotLocations);
		}
		*/
		
		/*
		public function AESegment(x:Number, y:Number, image:Image)
		{
			super(x,y, image.img(), image.width(), image.height());
			_torsoSlots = image.torsoSlots();
			this.appendageSlots = generateSlotsFromLocations(image.appendageSlots());
		}
		*/
		
		public function AESegment(x:Number, y:Number, schematic:AESchematic, shape:b2PolygonShape = null)
		{
			super(x,y, 0, schematic.img(), schematic.width(), schematic.height(), null);
			_torsoSlots = schematic.torsoSlots();
			appendageSlots = schematic.appendageSlots();


		}
		
		public function generateSlotsFromLocations(slotLocations:Array):Array
		{
			var slots:Array = new Array();
			for (var location:b2Vec2 in slotLocations)
			{
				slots.push(new AESlot(this, location));
			}
			return slots;
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withFriction(0.8)
				.withRestitution(0.3)
				.withDensity(0.7)
				.withLinearDamping(3.0)
				.withAngularDamping(30.0);
			if(shape != null){
				FlxG.log('Created with a different shape');
				b2bb.withShape(shape);
			}
			return b2bb;
		}
	}
}