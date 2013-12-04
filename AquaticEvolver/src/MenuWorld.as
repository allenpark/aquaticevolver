package
{
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxButton;
	public class MenuWorld extends AEWorld
	{
		 override public function create():void
		{
			super.create();
			player.kill(); 
			var menuText:FlxText = new FlxText(FlxG.width/2 - 48, FlxG.height/3, 100, "Aquatic Evolver!");
			menuText.scrollFactor.x = menuText.scrollFactor.y = 0 ; 
			add(menuText);
			var playButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 3*FlxG.height/7.0, "Start", startButtonCallback);
			playButton.scrollFactor.x = playButton.scrollFactor.y = 0 ; 
			add(playButton);
			var instructionButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 4*FlxG.height/7.0, "Instructions", instructionButtonCallback);
			instructionButton.scrollFactor.x = instructionButton.scrollFactor.y = 0 ; 
			add(instructionButton);
			var creditButton:FlxButton = new FlxButton(FlxG.width/2 - 45, 5*FlxG.height/7.0, "Credits", creditButtonCallback);
			creditButton.scrollFactor.x = creditButton.scrollFactor.y = 0 ; 
			add(creditButton);
			FlxG.mouse.show();
		}
		 public function startButtonCallback():void {
			 FlxG.switchState(new  AEWorld);
		 }
		 public function creditButtonCallback():void {
			 FlxG.switchState(new CreditState);
		 }
		 public function instructionButtonCallback():void {
			 FlxG.switchState(new InstructionState);
		 }
		
	}
}