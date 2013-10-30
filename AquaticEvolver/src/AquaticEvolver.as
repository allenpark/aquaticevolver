package  
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	public class AquaticEvolver extends FlxGame
	{
		public var pause:FlxGroup;

		public function AquaticEvolver() 
		{
			super(320,240,MenuState,2);
			//this.pause = new pausescreen();
			
		}
	}
}