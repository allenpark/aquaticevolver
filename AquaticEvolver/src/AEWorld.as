package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class AEWorld extends FlxState
	{
		[Embed(source="res/DestinyOfADroplet.mp3")] 	public var droplet:Class;
		
		public var paused:pausescreen;
		public var pauseGroup:FlxGroup;
		public var debug:FlxText;
		FlxG.debug = true;
		
		/**
		 * The player character, sharing a common inherited ancestor as other NPC creatures.
		 * -- MRP - 11/11/2013
		 */
		public var player:Creature;
		
		/**
		 * The box2D world, into which we must add all Box2D objects if
		 * we want them to be a part of the simulation that Box2D runs.
		 * -- Nick Benson - 10/28/2013
		 */
		public static var box2dWorld:b2World;
		
		/**
		 * The pull of gravity. There is normal gravity underwater, but there are
		 * counter-active bouyancy effects. We'll need to fiddle with this number
		 * to get it to feel right. We should also treat this as a constant and
		 * only ever modify it HERE in the code.
		 * Remember, Box2D works in kilograms, meters, and seconds. This constant
		 * is in m^2 / s^2.
		 * -- Nick Benson - 10/28/2013
		 */
		public var GRAVITY:b2Vec2 = new b2Vec2(0, 0);
		
		/**
		 * 
		 */
		public static const RATIO:Number = 100.0;

		/* We should probably refer to these as "cameraX", etc., unless it doesn't
		* actually mean what I think it means. -- Nick Benson - 10/28
		*/
		public var screenX:int; // The x coordinate of the upper left corner of the screen.
		public var screenY:int; // The y coordinate of the upper left corner of the screen.
		public var screenWidth:int;
		public var screenHeight:int;
		public var defaultHealth:int;
		public var defaultSpeed:Number;
		
		/**
		 * Constructs and initializes the Box2D b2World.
		 */
		public function createBox2DWorld():void {
			// Takes a gravity argument and a "doSleep" argument.
			// doSleep is a good thing. Look it up if you're considering
			// changing it. --Nick Benson - 10/28/2013
			box2dWorld = new b2World(GRAVITY, true);
		}
		
		// Creates an enemy randomly slightly off screen.
		public function addOffscreenEnemy(xBuffer: int = 0, yBuffer: int = 0):void {
			var newX:Number;
			var newY:Number;
			if (Math.random() > 0.5) {
				// On the vertical edges.
				newX = (Math.random() > 0.5 ? -xBuffer : this.screenWidth) + this.screenX;
				newY = (Math.random() * (this.screenHeight + yBuffer) - yBuffer) + this.screenY;
			} else {
				// On the horizontal edges.
				newX = (Math.random() * (this.screenWidth + xBuffer) - xBuffer) + this.screenX;
				newY = (Math.random() > 0.5 ? -yBuffer : this.screenHeight) + this.screenY;
				
			}
			var newEnemy:BoxEnemy = new BoxEnemy(newX, newY, this.defaultSpeed, this.defaultHealth, this.defaultHealth, new Array());
			this.add(newEnemy);
			this.add(newEnemy.healthDisplay);
		}
		
		override public function create():void
		{
			super.create();
			// Set up the screen properties (or are they camera properties?)
			FlxG.bgColor = 0xff3366ff;
			this.screenX = FlxG.camera.scroll.x;
			this.screenY = FlxG.camera.scroll.y;
			this.screenWidth = FlxG.width;
			this.screenHeight = FlxG.height;
			this.defaultHealth = 10;
			this.defaultSpeed = 5.0;
			
			// Construct the Box 2D world (in which all simulation happens)
			this.createBox2DWorld();
			
			//Create player (a red box)
			this.player = new Boxplayer(this.screenWidth / 2, this.screenHeight / 2, this.defaultSpeed, this.defaultHealth, this.defaultHealth, new Array()); 
			var start_adaptation : Adaptation = (new Adaptation('tentacle', player.x + 10, player.y, 0));
			this.add(start_adaptation);
			player.addAdaptation(start_adaptation);
			add(player);		
			
			//Music
			FlxG.playMusic(droplet);
			
			//Pausing
			FlxG.paused = false;
			paused = new pausescreen;
			
			var newEnemy:BoxEnemy = new BoxEnemy(50, 50, this.defaultSpeed, this.defaultHealth, this.defaultHealth, new Array());
			add(newEnemy);
			this.add(newEnemy.healthDisplay);
			
			//FlxG.camera.follow(player);
			
			//Box2D debug stuff
			var debugDrawing:DebugDraw = new DebugDraw();
			debugDrawing.debugDrawSetup(box2dWorld, RATIO, 1.0, 1, 0.5);
			
			//Flx Debug
			FlxG.watch(player, "x");
			FlxG.watch(player, "y");
			FlxG.watch(player, "width");
			FlxG.watch(player, "height");
		}
		
		override public function update():void {
			super.update();
			box2dWorld.Step(1.0/60.0, 10, 10);
			
			//Box2D debug stuff
			if (AquaticEvolver.box2dDebug) {
				box2dWorld.DrawDebugData();
			}
			if(FlxG.keys.justPressed("D")){
				AquaticEvolver.box2dDebug = !AquaticEvolver.box2dDebug;
				AquaticEvolver.DEBUG_SPRITE.visible = AquaticEvolver.box2dDebug;
			}
			
			if (!paused.showing) {
				//this.screenX = FlxG.camera.scroll.x;
				//this.screenY = FlxG.camera.scroll.y;
				
				if(FlxG.keys.justPressed("P")){
					paused = new pausescreen();
					paused.displayPaused();
					
					//player.kill();
					//paused.finishCallback = dialogKill;
					add(paused);		
					FlxG.music.pause();
				} 

				if(FlxG.keys.justPressed("G")){
					FlxG.switchState(new GameOverState)				
				}
			}
			else
			{
				paused.update();
			}
		}
	}
}