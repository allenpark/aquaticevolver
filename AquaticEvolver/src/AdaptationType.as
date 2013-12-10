package
{
	public class AdaptationType
	{
		public static const SPIKE:Number = 1;
		public static const TENTACLE:Number = 2;
		public static const MANDIBLE:Number = 3;
		public static const BUBBLEGUN:Number = 4;
		public static const SPIKESHOOTER: Number = 5;
		public static const CLAW: Number = 6;
		public static const POISONCANNON: Number = 7;
		public static const SHELL: Number = 8;
		public static const HEALTHINCREASE: Number = 9; // not an appendage
		public static const SPEEDINCREASE: Number = 10; // not an appendage
		
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
		
		public static function toString(adaptationType:Number):String {
			switch (adaptationType) {
				case SPIKE:
					return "Spike";
				case TENTACLE:
					return "Tentacle";
				case MANDIBLE:
					return "Mandible";
				case BUBBLEGUN:
					return "Bubble gun";
				case SPIKESHOOTER:
					return "Spike shooter";
				case CLAW:
					return "Claw";
				case POISONCANNON:
					return "Poison cannon";
				case SHELL:
					return "Shell";
				case HEALTHINCREASE:
					return "Health increase";
				case SPEEDINCREASE:
					return "Speed increase";
				default:
					return "Nothing";
			}
			return "";
		}
	}
}