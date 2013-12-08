package
{
	import org.flixel.*;
	import AEWorld;
	
	public class GameOverState extends AEWorld
	{
		
		[Embed (source = "res/restart.png")] public var restartButtonImg :Class;
		[Embed (source = "res/gameover.png")] public var gameOverText:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;
		[Embed (source = "res/mainmenu.png")] public var mainMenuImg:Class;




		override public function create():void
		{
			
			super.create();
			player.kill(); 
			var gameText:FlxSprite = new FlxSprite(FlxG.width/2 - 250, 0, gameOverText);
			gameText.scrollFactor.x = gameText.scrollFactor.y = 0 ; 
			add(gameText);
			var playButton:FlxButton = new FlxButton(FlxG.width/2 - 65, 2*FlxG.height/7.0, "", replayCallback);
			playButton.scrollFactor.x = playButton.scrollFactor.y = 0 ;
			playButton.loadGraphic(restartButtonImg);
			add(playButton);
		
			FlxG.mouse.load(cursorImg);
			FlxG.mouse.show();
			
			var menuButton:FlxButton = new FlxButton(FlxG.width/2 - 135, 4*FlxG.height/7.0, "", mainMenuCallback);
			menuButton.scrollFactor.x = menuButton.scrollFactor.y = 0 ;
			menuButton.loadGraphic(mainMenuImg);
			add(menuButton);
			
			FlxG.mouse.load(cursorImg);
			FlxG.mouse.show();
		
			

		}
		
		public function replayCallback():void{
			FlxG.switchState(new AEWorld);
		}
		public function mainMenuCallback():void{
			FlxG.switchState(new MenuWorld);
		}
	}
}
