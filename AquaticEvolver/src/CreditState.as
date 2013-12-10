package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class CreditState extends AEWorld
	{
		
		[Embed (source = "res/mainmenu.png")] public var mainMenuImg:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;

		//Variable to controll the speed at which text will move on the screen 
		public var scroll_speed:int = 50; 
		//A list to keep track of all the things we want on the credits, the last item in the list will go first 
		public var text_list: Array  = ["Some sound effects provided royalty-free from sounddogs.com" ,"Legal", "", "", "Nick Benson", "Producer", "", "Marcel Polanco", "Scrum Master", "", "Marcel Polanco", "Carlo Biedenharn", "Travis Wagner", "Justin White", "Allen Park", "Nick Benson", "Rohan Mahajan", "Jancarlo Perez", "Jan Rodriguez", "Skyler Seto", "Pedro Cattori", "Main Contributors "]; 
		//A variable that will keep track of time so all the credits don't come at once
		public var counter:Number = 0 ; 
		override public function create():void
		{
			super.create();
			player.kill(); 

			var menuButton:FlxButton = new FlxButton(FlxG.width/2 - 65, 2*FlxG.height/7.0, "", menuButtonCallback);
			menuButton.scrollFactor.x = menuButton.scrollFactor.y = 0 ;
			menuButton.loadGraphic(mainMenuImg);
			add(menuButton);
			
			// Stop wrong music from playing
			FlxbattleMusic.stop();
			FlxexploreMusic.stop();
		}
		override public function update():void
		{
			if (counter == 0) 
			{
				//At the open of the screen or when 3 seconds have passed, 
				var words:String  = text_list.pop(); 
				CreditScroll(words); 
			}
			counter += FlxG.elapsed;
			if (counter >= 3)
			{
				// After 3 seconds has passed, the timer will reset.
				counter = 0;
			}
			super.update()
			
		}
		
		public function menuButtonCallback():void
		{
			AEEnemy.killAll();
			FlxG.resetGame();
		}
		public function CreditScroll (credit_words:String) : void 
		{
			var text:FlxText = new FlxText(60  ,FlxG.height +50 ,FlxG.width,credit_words);
			text.alignment = "center" ; 
			text.size = 60;
			add (text);
			text.velocity.y = -scroll_speed
			
			
			
		}
	}
}

