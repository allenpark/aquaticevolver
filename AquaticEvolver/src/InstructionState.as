package
{
	
	import org.flixel.*;
	import org.flixel.FlxState;
	
	public class InstructionState extends AEWorld
	{
		[Embed (source = "res/mainmenu.png")] public var mainMenuImg:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;
		
		override public function create():void
		{
			
			
			
			super.create();
			player.kill(); 
			
			var instructions:String = "Press the arrow keys to move and click to move\n";
			
			add(new FlxText(FlxG.width/2-50, FlxG.height/5,2000,instructions));
			
			var menuButton:FlxButton = new FlxButton(FlxG.width/2 - 65, 2*FlxG.height/7.0, "", mainMenuCallback);
			menuButton.scrollFactor.x = menuButton.scrollFactor.y = 0 ;
			menuButton.loadGraphic(mainMenuImg);
			add(menuButton);	
			
			
		}
		public function mainMenuCallback():void{
			FlxG.resetGame();
		}
	}
}