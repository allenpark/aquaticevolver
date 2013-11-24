package Images
{
	import Box2D.Common.Math.b2Vec2;

	public class Tail1Image extends Image
	{
		private static const width:Number = 64;
		private static const height:Number = 64;
		
		[Embed(source='../res/Tail1.png')]
		public static const img:Class;
		
		public static const tailAnchor:b2Vec2 = Image.getB2Vec2FromFlxCoords(50,32,width,height);
		
		public static const slot1:b2Vec2 = Image.getB2Vec2FromFlxCoords(11,32, width, height);
	}
}