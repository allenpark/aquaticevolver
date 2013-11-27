package Creature.Schematics
{
	import flash.utils.Dictionary;
	
	import Box2D.Common.Math.b2Vec2;
	import Creature.Images.AEImage;

	/**
	 * Schematic for making AESegments. Keeps track of image info (image file, width, height), 
	 * appendage slot locations, and torso slot locations.
	 */
	public class AESchematic
	{	
		protected var _image:AEImage;
		
		protected var _appendageSlots:Array;
		protected var _torsoSlots:Dictionary;
		
		protected var _headAnchor:b2Vec2;
		protected var _tailAnchor:b2Vec2;
		
		public function AESchematic(image:AEImage, appendageSlots:Array=null, torsoSlots:Dictionary=null)
		{
			_image = image;
			_appendageSlots = appendageSlots;
			_torsoSlots = torsoSlots;
		}
		
		public static function b2Vec2FromFlxCoords(x:Number, y:Number, width:Number, height:Number):b2Vec2
		{
			var centerX:Number = width/2.0;
			var centerY:Number = height/2.0;
			return new b2Vec2(AEWorld.b2NumFromFlxNum(x - centerX),AEWorld.b2NumFromFlxNum(y - centerY));
		}
		
		public function width():Number
		{
			return _image.getWidth();
		}
		
		public function height():Number
		{
			return _image.getHeight();
		}
		
		public function img():Class
		{
			return _image.getImg();
		}
		
		public function appendageSlots():Array
		{
			return _appendageSlots;
		}
		
		public function torsoSlots():Dictionary
		{
			return _torsoSlots;
		}
	}
}