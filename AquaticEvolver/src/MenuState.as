package
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import World;
	
	public class MenuState extends FlxState
	{
		
		override public function create():void
		{
			super.create();
			FlxG.bgColor = 0xffaaaaaa;
			var menuText:FlxText = new FlxText(FlxG.width/2 - 48, FlxG.height/3, 100, "Aquatic Evolver!");
			add(menuText);
			var playButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 3*FlxG.height/7.0, "Start", startButtonCallback);
			add(playButton);
			var instructionButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 4*FlxG.height/7.0, "Instructions", instructionButtonCallback);
			add(instructionButton);
			var creditButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 5*FlxG.height/7.0, "Credits", creditButtonCallback);
			add(creditButton);
			FlxG.mouse.show();
		}
		public function startButtonCallback():void {
			FlxG.switchState(new AEWorld);
		}
		public function creditButtonCallback():void {
			FlxG.switchState(new CreditState);
		}
		public function instructionButtonCallback():void {
			FlxG.switchState(new InstructionState);
		}
	}
}
