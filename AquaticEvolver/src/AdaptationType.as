package
{
	public class AdaptationType
	{
		public static var SPIKE:Number = 1;
		public static var TENTACLE:Number = 2;
		public static var MANDIBLE:Number = 3;
		public static var BUBBLEGUN:Number = 4;
		public static var SPIKESHOOTER: Number = 5;
		public static var CLAW: Number = 6;
		public static var POISONCANNON: Number = 7;
		public static var SHELL: Number = 8;
		public static var HEALTHINCREASE: Number = 9; // not an appendage
		public static var SPEEDINCREASE: Number = 10; // not an appendage
		
		public function AdaptationType()
		{
		}
		
		public static function isAppendage(adaptationType:Number):Boolean
		{
			if (adaptationType == AdaptationType.HEALTHINCREASE || adaptationType == AdaptationType.SPEEDINCREASE)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
}