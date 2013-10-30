package
{
	import org.flixel.*;
	public class PauseScreen extends FlxGroup
	{
		public var pauseGroup:FlxGroup;
		public function pauseScreen():void
		{
			FlxG.bgColor = 0xff783629;
		}
		
		override public function update():void
		{			
			FlxG.bgColor = 0xff783629;
			if (FlxG.keys.justPressed("P")) {
				if(!FlxG.paused) {
					FlxG.paused = true;
					pauseGroup.revive();
				} 
				else {
					FlxG.paused = false;
					pauseGroup.alive = false;
					pauseGroup.exists = false;
				}
			}

		}
		
	}
}