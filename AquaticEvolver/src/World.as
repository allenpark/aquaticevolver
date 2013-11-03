// ActionScript file

/**
 * World.as
 * 
 * This file is going to handle the construction of the Box2D b2World
 * as well as any other global or World-related aspects of Aquatic Evolver.
 * 
 * If you plan on messing with physics-related things in this game you
 * should skim through the basics of Box2D's as3 implementation so you
 * have an idea of what things really are in the context of Box2D.
 * 		http://www.box2dflash.org/docs/2.0.2/manual
 * 
 * Note: The above link is the documentation for 2.0, and we're using
 * Box2D's 2.1a implementation of the engine. The differences are minor
 * but they're useful enough that I think 2.1a is worth using over 2.0.
 * Documentation on the differences can be read very quickly here:
 * 		http://www.box2dflash.org/docs/2.1a/updating
 * 
 * In addition, this is a resource you should read through for making
 * Box2D interact with Flixel. It's what I used to get Box2D imported and
 * get the world instantiated.
 * 
 * --Nick Benson - 10/28
 * 
 */

package {
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class World extends FlxState {
		[Embed(source="res/DestinyOfADroplet.mp3")] 	public var droplet:Class;

		public var paused:pausescreen;
		public var pauseGroup:FlxGroup;
		public var debug:FlxText;

		
		/**
		 * The player character, sharing a common inherited ancestor as other NPC creatures.
		 * -- Nick Benson - 10/28/2013
		 */
		public var player:Creature;
		
		/**
		 * An array of enemies that are currently spawned, which in general should only be enemies
		 * that are on the screen or near the screen in the game world.
		 * -- Nick Benson - 10/28/2013
		 */
		public var enemies:Array;
		
		/**
		 * The box2D world, into which we must add all Box2D objects if
		 * we want them to be a part of the simulation that Box2D runs.
		 * -- Nick Benson - 10/28/2013
		 */
		public var box2dWorld:b2World;
		
		/**
		 * The pull of gravity. There is normal gravity underwater, but there are
		 * counter-active bouyancy effects. We'll need to fiddle with this number
		 * to get it to feel right. We should also treat this as a constant and
		 * only ever modify it HERE in the code.
		 * Remember, Box2D works in kilograms, meters, and seconds. This constant
		 * is in m^2 / s^2.
		 * -- Nick Benson - 10/28/2013
		 */
		public var GRAVITY:b2Vec2 = new b2Vec2(0, 9.8);
		
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
		public function createEnemy(xBuffer: int = 0, yBuffer: int = 0):void {
			// TODO: fill enemyPhenotypes in.
			var enemyPhenotypes:Array = new Array();
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
			var newEnemy:Enemy = new Enemy(newX, newY, this.defaultSpeed, this.defaultHealth, this.defaultHealth, enemyPhenotypes) 
			this.enemies.push(newEnemy); 
			add(newEnemy);
		}
		
		// Checks that all enemies are still on screen.
		public function removeEnemiesNotOnScreen(xBuffer:int = 0, yBuffer:int = 0):void {
			for (var i:int = this.enemies.length - 1; i >= 0; i--) {
				var enemy:Creature = this.enemies[i];
				if (!this.inScreen(enemy.x, enemy.y, xBuffer, yBuffer)) {
					this.enemies.splice(i, 1);
				}
			}
		}
		
		// Returns if (x, y) are in the screen. Tolerates points xBuffer outside the x range and yBuffer 
		// outside the y range with defaults of xBuffer = 0 and yBuffer = 0.
		public function inScreen(x:int, y:int, xBuffer:int = 0, yBuffer:int = 0):Boolean {
			var inX:Boolean = x >= this.screenX - xBuffer && x < this.screenX + this.screenWidth + xBuffer;
			var inY:Boolean = y >= this.screenY - yBuffer && y < this.screenY + this.screenHeight + yBuffer;
			return inX && inY;
		}
		
		override public function create():void
		{
			// Set up the screen properties (or are they camera properties?)
			this.screenX = 0;
			this.screenY = 0;
			this.screenWidth = FlxG.width;
			this.screenHeight = FlxG.height;
			this.defaultHealth = 10;
			this.defaultSpeed = 5.0;
			
			var playerPhenotypes:Array = new Array(); // TODO: fill this in.
			//Create player (a red box)
			this.player = new Player(this.screenWidth / 2, this.screenHeight / 2, this.defaultSpeed, this.defaultHealth, this.defaultHealth, playerPhenotypes); 
			this.enemies = new Array();
			this.debug = new FlxText(FlxG.width/2-30, FlxG.height/5,300,"num enemies: " + this.enemies.length);
			
			// Construct the Box 2D world (in which all simulation happens)
			this.createBox2DWorld();

			FlxG.playMusic(droplet);
			
			FlxG.bgColor = 0xff3366ff;
			FlxG.paused = false;
			paused = new pausescreen;
			
			add(player);
		}
		
		override public function update():void {
			
			if (!paused.showing) {
				
				super.update();
				
				
				
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
			
				// TODO: do magic.
				this.player.update();
				for (var i:int = 0; i < this.enemies.length; i++) {
					this.enemies[i].update();
					trace("x: " + this.enemies[i].x + "y: " + this.enemies[i].y);
				}
				this.debug.kill();
				this.debug = new FlxText(FlxG.width/2-30, FlxG.height/5,300,"num enemies: " + this.enemies.length); 
				add(this.debug);
				var enemyWidth:int = 15; // TODO: make this the enemy width and height.
				var enemyHeight:int = 15;
				this.removeEnemiesNotOnScreen(2 * enemyWidth, 2 * enemyHeight);
				if (Math.random() < 0.02) {
					this.createEnemy(enemyWidth, enemyHeight);
				}
			}
			else{
				paused.update();
			}
			
		}
		public function display():void {
			// TODO: more magic.
			this.player.display();
			for (var i:int = 0; i < this.enemies.length; i++) {
				this.enemies[i].display();
			}
		}
	}
}
