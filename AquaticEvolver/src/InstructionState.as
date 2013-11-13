package
{
	import org.flixel.FlxState;
	import org.flixel.*;
	import AEWorld;
	
	public class InstructionState extends FlxState
	{
		override public function create():void
		{
			super.create();
			FlxG.bgColor = 0xffaaaaaa;
			
			var instructions = "Press the arrow keys to move\n";
			
			add(new FlxText(FlxG.width/2-30, FlxG.height/5,300,instructions));
			var backButton:FlxButton = new FlxButton(FlxG.width/2 -45, 3*FlxG.height/5, "Back", mainMenuCallback);
			add(backButton);
			
			
		}
		public function mainMenuCallback():void{
			FlxG.resetGame();
		}
	}
}