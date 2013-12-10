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
			var gameText:FlxSprite = new FlxSprite(FlxG.width/2 - 135, 150, gameOverText);
			gameText.scrollFactor.x = gameText.scrollFactor.y = 0 ; 
			add(gameText);
			var playButton:FlxButton = new FlxButton(FlxG.width/2 - 135, 0.10*FlxG.height + 150, "", replayCallback);
			playButton.scrollFactor.x = playButton.scrollFactor.y = 0 ;
			playButton.loadGraphic(restartButtonImg);
			add(playButton);
		
			FlxG.mouse.load(cursorImg);
			FlxG.mouse.show();
			
			var menuButton:FlxButton = new FlxButton(FlxG.width/2 - 135, 0.30*FlxG.height + 150, "", mainMenuCallback);
			menuButton.scrollFactor.x = menuButton.scrollFactor.y = 0 ;
			menuButton.loadGraphic(mainMenuImg);
			add(menuButton);
			
			FlxG.mouse.load(cursorImg, 1, -32, -32);
			FlxG.mouse.show();
		
			

		}
		
		public function replayCallback():void{
			FlxexploreMusic.kill();
			FlxbattleMusic.kill();
			AEEnemy.killAll();
			FlxG.switchState(new AEWorld);
		}
		public function mainMenuCallback():void{
			AEEnemy.killAll();
			FlxG.resetGame();
		}
	}
}
