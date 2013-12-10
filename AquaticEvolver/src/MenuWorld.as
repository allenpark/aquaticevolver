package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	public class MenuWorld extends AEWorld
	{
		[Embed (source = "res/title.png")] public var titleText:Class;
		[Embed (source = "res/play.png")] public var playButtonImg:Class;
		[Embed (source = "res/instructions.png")] public var instructionButtonImg:Class;
		[Embed (source = "res/credits.png")] public var creditsButtonImg:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;
		[Embed(source="res/Headwinds.mp3")] 	public var mainMenuMusic:Class;
		public var FlxMainMenuMusic : FlxSound = new FlxSound();
		
		public var buttonOffset:FlxPoint = new FlxPoint(10,10)
		
		
		 override public function create():void
		{
			super.create();
			player.kill(); 
			var menuText:FlxSprite = new FlxSprite(FlxG.width/2 - 250, 0, titleText);
			menuText.scrollFactor.x = menuText.scrollFactor.y = 0 ; 
			add(menuText);
			var playButton:FlxButton = new FlxButton(FlxG.width/2 - 65, 2*FlxG.height/7.0, "", startButtonCallback);
			playButton.scrollFactor.x = playButton.scrollFactor.y = 0 ;
			playButton.loadGraphic(playButtonImg);
			add(playButton);
			var instructionButton:FlxButton = new FlxButton(FlxG.width/2 -120, 3*FlxG.height/7.0, "", instructionButtonCallback);
			instructionButton.scrollFactor.x = instructionButton.scrollFactor.y = 0 ; 
			instructionButton.loadGraphic(instructionButtonImg);
			add(instructionButton);
			var creditButton:FlxButton = new FlxButton(FlxG.width/2 - 125, 4*FlxG.height/7.0, "", creditButtonCallback);
			creditButton.scrollFactor.x = creditButton.scrollFactor.y = 0 ; 
			creditButton.loadGraphic(creditsButtonImg);
			add(creditButton);
			FlxG.mouse.show();
			FlxG.mouse.load(cursorImg, 1, -32, -32);
			FlxMainMenuMusic.loadEmbedded(mainMenuMusic,true);
			FlxMainMenuMusic.play();
				
		}
		 public function startButtonCallback():void {
			 FlxMainMenuMusic.kill();
			 AEEnemy.killAll();
			 FlxG.switchState(new AEWorld);
		 }
		 public function creditButtonCallback():void {
			 AEEnemy.killAll();
			 FlxG.switchState(new CreditState);
		 }
		 public function instructionButtonCallback():void {
			 AEEnemy.killAll();
			 FlxG.switchState(new InstructionState);
		 }
		
	}
}