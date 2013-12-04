package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxGroup;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	public class AquaticEvolver extends FlxGame
	{
		public static var DEBUG_SPRITE:Sprite;
		public var pause:FlxGroup;
		//Box2D debug flag... set to false to turn off box2d debug drawings
		public static var box2dDebug:Boolean = false;

		public function AquaticEvolver() 
		{
			
			super(640,480,MenuWorld,1);
			// this.pause = new PauseScreen();
			forceDebugger = true;
			//Box2D debug stuff
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		//Box2D debug stuff
		private function addedToStage(e:Event):void{
			DEBUG_SPRITE = new Sprite;
			FlxG.stage.addChild(DEBUG_SPRITE);
		}
	}
}