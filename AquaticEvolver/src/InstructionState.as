package
{
	
	import org.flixel.*;
	import org.flixel.FlxState;
	
	public class InstructionState extends FlxState
	{
		override public function create():void
		{
			super.create();
			FlxG.bgColor = 0xffaaaaaa;
			
			var instructions:String = "Press the arrow keys to move\n";
			
			add(new FlxText(FlxG.width/2-30, FlxG.height/5,300,instructions));
			var backButton:FlxButton = new FlxButton(FlxG.width/2 -45, 3*FlxG.height/5, "Back", mainMenuCallback);
			add(backButton);
			
			
		}
		public function mainMenuCallback():void{
			FlxG.resetGame();
		}
	}
}