package Images
{
	import Box2D.Common.Math.b2Vec2;

	public class Head1Image extends Image
	{
		private static const width:Number = 128;
		private static const height:Number = 128;

		[Embed(source='../res/Head1.png')]
		public static const img:Class;
				
		public static const headAnchor:b2Vec2 = Image.getB2Vec2FromFlxCoords(36,64,width,height);
		
		public static const slot1:b2Vec2 = Image.getB2Vec2FromFlxCoords(91,64, width, height);
	}
}