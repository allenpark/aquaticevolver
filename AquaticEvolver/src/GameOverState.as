package
{
	import org.flixel.*;
	import World;
	
	public class GameOverState extends FlxState
	{
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			add(new FlxText(FlxG.width/2-30, FlxG.height/5,300,"GAME OVER"));
			var playButton:FlxButton = new FlxButton(FlxG.width/2 -45, 3*FlxG.height/5, "Replay", replayCallback);
			add(playButton);
			var creditButton:FlxButton = new FlxButton(FlxG.width/2 -45,4*FlxG.height/5, "Main Menu", mainMenuCallback);
			add(creditButton);
			

		}
		
		public function replayCallback():void{
			FlxG.switchState(new World);
		}
		public function mainMenuCallback():void{
			FlxG.resetGame();
		}
	}
}