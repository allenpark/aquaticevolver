package Creature.Images
{
	import Box2D.Common.Math.b2Vec2;
	import Creature.Schematics.AESchematic;

	public class Tail1
	{
		public static const WIDTH:Number = 64;
		public static const HEIGHT:Number = 64;
		
		[Embed(source='../../res/Tail1.png')]
		public static const IMG:Class;
		
		public static const suggestedTailAnchor:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(50,32,WIDTH,HEIGHT);
		
		public static const suggestedAppendageSlot1:b2Vec2 = AESchematic.b2Vec2FromFlxCoords(11,32, WIDTH, HEIGHT);
		public static const suggestedAppendageSlots:Array = new Array(suggestedAppendageSlot1);

		public static function image():AEImage
		{
			return new AEImage(IMG,WIDTH,HEIGHT);
		}
	}
}