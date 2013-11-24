package Creature.CreatureSchematics
{
	import Box2D.Common.Math.b2Vec2;
	import flash.utils.Dictionary;

	public class Schematic
	{	
		protected var _appendageSlots:Array;
		protected var _torsoSlots:Dictionary;
		
		public function Schematic(appendageSlots:Array=null, torsoSlots:Dictionary=null)
		{
			_appendageSlots = appendageSlots;
			_torsoSlots = torsoSlots;
		}
		
		public static function getB2Vec2FromFlxCoords(x:Number, y:Number, width:Number, height:Number):b2Vec2
		{
			var centerX:Number = width/2.0;
			var centerY:Number = height/2.0;
			return new b2Vec2(AEWorld.b2NumFromFlxNum(x - centerX),AEWorld.b2NumFromFlxNum(y - centerY));
		}
		
		public function width():Number
		{
			return null;
		}
		
		public function height():Number
		{
			return null;
		}
		
		public function img():Class
		{
			return null;
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