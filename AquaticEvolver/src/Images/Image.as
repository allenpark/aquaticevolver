package Images
{
	import Box2D.Common.Math.b2Vec2;

	public class Image
	{
		
		public function Image()
		{
		}
		
		public static function getB2Vec2FromFlxCoords(x:Number, y:Number, width:Number, height:Number):b2Vec2
		{
			var centerX:Number = width/2.0;
			var centerY:Number = height/2.0;
			return new b2Vec2(AEWorld.b2NumFromFlxNum(x - centerX),AEWorld.b2NumFromFlxNum(y - centerY));
		}
	}
}