package Images
{
	import Box2D.Common.Math.b2Vec2;

	public class Torso1Image extends Image
	{
		private static const width:Number = 128;
		private static const height:Number = 128;
		
		[Embed(source='../res/Torso1.png')]
		public static const img:Class;
		
		public static const headAnchor:b2Vec2 = Image.getB2Vec2FromFlxCoords(96,64,width,height);
		public static const tailAnchor:b2Vec2 = Image.getB2Vec2FromFlxCoords(28,64,width,height);
		
		public static const slot1:b2Vec2 = Image.getB2Vec2FromFlxCoords(93,87, width, height);
		public static const slot2:b2Vec2 = Image.getB2Vec2FromFlxCoords(65,98, width, height);
		public static const slot3:b2Vec2 = Image.getB2Vec2FromFlxCoords(34,87, width, height);
		public static const slot4:b2Vec2 = Image.getB2Vec2FromFlxCoords(93,23, width, height);
		public static const slot5:b2Vec2 = Image.getB2Vec2FromFlxCoords(65,34, width, height);
		public static const slot6:b2Vec2 = Image.getB2Vec2FromFlxCoords(34,23, width, height);
	}
}