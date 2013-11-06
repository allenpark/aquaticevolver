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
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;


	public class World extends FlxState {
		[Embed(source="res/DestinyOfADroplet.mp3")] 	public var droplet:Class;

		public var paused:pausescreen;
		public var pauseGroup:FlxGroup;
		public var debug:FlxText;
		FlxG.debug = true ; 
		// Added hearts to represent player health
		[Embed(source = "res/life.png")] private var heartImage:Class;
		// Using a temp player health until player health is working
		// and updating
		public var tempPlayerHealth:int = 5;
		public var maxPlayerHealth:int = 10;


		
		/**
		 * 
		 * Array representing the health images
		 */
		public var lifeimage:Array = new Array();
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
		public var enemyGroup:FlxGroup;
		
		/**
		 * Array of all background objects drawn on the world. To assure that we do not draw too
		 * many at the same tiem
		 */
		public var backgroundGroup:FlxGroup;
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
		
		public function drawBackgroundObject(xBuffer:int = 0, yBuffer: int =0):void{
			var newX:Number;
			var newY:Number;
			// On the vertical edges.
			newX = (Math.random() * this.screenWidth);
//			newY = Math.random() > .5? 0 : this.screenHeight;
			newY = this.screenHeight-yBuffer;
			
			var viewDistance:int = Math.round(Math.random()*5)+5;
			
			var backgroundObject:BackgroundObject = new BackgroundObject(newX, newY, viewDistance, FlxG.camera);
			backgroundObject.floatUpward();
			
//			this.backgroundGroup.add(backgroundObject);
			this.add(backgroundObject);			
		}
		
		
		// Creates an enemy randomly slightly off screen.
		public function createEnemy(xBuffer: int = 0, yBuffer: int = 0):void {
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
			var newEnemy:BoxEnemy = new BoxEnemy(this, newX, newY, this.defaultSpeed, this.defaultHealth, this.defaultHealth, box2dWorld);
			this.enemyGroup.add(newEnemy);
			this.add(newEnemy);
		}
		
		// Checks that all enemies are still on screen.
//		public function removeObjNotOnScreen(xBuffer:int = 0, yBuffer:int = 0):void {
//			for (var i:int = this.backgroundGroup.length - 1; i >= 0; i--) {
//				var object:BackgroundObject = this.backgroundGroup.members[i];
//				if (!this.inScreen(object.x, object.y, xBuffer, yBuffer)) {
//					this.backgroundGroup.remove(object, true);
//					object.kill();
//					object.destroy();
//				}
//			}
//		}
		
		// Checks that all enemies are still on screen.
		public function removeEnemiesNotOnScreen(xBuffer:int = 0, yBuffer:int = 0):void {
			for (var i:int = this.enemyGroup.length - 1; i >= 0; i--) {
				var enemy:Creature = this.enemyGroup.members[i];
				if (!this.inScreen(enemy.x, enemy.y, xBuffer, yBuffer)) {
					this.enemyGroup.remove(enemy, true);
					enemy.kill();
					enemy.destroy();
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
			super.create();
			// Set up the screen properties (or are they camera properties?)
			FlxG.bgColor = 0xff000000;
			this.screenX = FlxG.camera.scroll.x;
			this.screenY = FlxG.camera.scroll.y;
			this.screenWidth = FlxG.width;
			this.screenHeight = FlxG.height;
			this.defaultHealth = 10;
			this.defaultSpeed = 5.0;
			
			// Construct the Box 2D world (in which all simulation happens)
			this.createBox2DWorld();
			
			//Create player (a red box)
			this.player = new Boxplayer(this, this.screenWidth / 2, this.screenHeight / 2, this.defaultSpeed, this.defaultHealth, this.defaultHealth, box2dWorld); 
			var start_adaptation : Adaptation = (new Adaptation('tentacle', player.x + 10, player.y, 0));
			this.add(start_adaptation);
			player.addAdaptation(start_adaptation);
			this.enemyGroup = new FlxGroup();
			
//			this.debug = new FlxText(FlxG.width/2-30, FlxG.height/5,300,"num enemies: " + this.enemyGroup.length);
//			
//			this.debug = new FlxText(FlxG.width/2-30, FlxG.height/5,300,"num enemies: " + this.enemyGroup.length);
//			this.add(this.debug);			

			FlxG.playMusic(droplet);
			
			FlxG.bgColor = 0xff3366ff;
			FlxG.paused = false;

			paused = new pausescreen;
			
			add(player);
			
			//FlxG.camera.follow(player);
			for (var i:int = 0; i < maxPlayerHealth; i ++) {
				lifeimage[i] = new FlxSprite(this.screenX + 220 + 20 * i, this.screenY + 220, heartImage); 
			}
			var newEnemy:BoxEnemy = new BoxEnemy(this, 50, 50, this.defaultSpeed, this.defaultHealth, this.defaultHealth, box2dWorld);
			add(newEnemy);
			
			//FlxG.camera.follow(player);
			
			//Box2D debug stuff

			var debugDrawing:DebugDraw = new DebugDraw();
			debugDrawing.debugDrawSetup(box2dWorld, RATIO, 1.0, 1, 0.5);

			for(var k:int=tempPlayerHealth - 1; k >= 0; k--){
				 this.add(lifeimage[k]);
			}
			FlxG.watch(player, "x");
			FlxG.watch(player, "y");
			FlxG.watch(player, "width");
			FlxG.watch(player, "height");
		}
		
		public function hitEnemy(adaptation:Adaptation, enemy:Enemy):void {
			if (enemy.getAttacked(adaptation.attackDamage)){
				this.enemyGroup.remove(enemy, true);
				enemy.destroy();
			}

		}
		
		override public function update():void {
			super.update();
			box2dWorld.Step(1.0/60.0, 10, 10);
			//Box2D debug stuff
			if (AquaticEvolver.box2dDebug) {
				box2dWorld.DrawDebugData();
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
			
				// TODO: do magic.
				this.player.update();
				for (var j:int = 0; j < this.enemyGroup.length; j++) {
				    this.enemyGroup.members[j].updateMove(this.enemyGroup);
					this.enemyGroup.members[j].update();
				}

//				FlxG.collide(this.player.adaptationGroup, this.enemyGroup, hitEnemy);
//				this.debug.text = "num enemies: " + this.enemyGroup.length;
//				this.debug.x = this.screenX + FlxG.width/2-30;
//				this.debug.y = this.screenY + FlxG.height/5;

				//this.debug = new FlxText(this.screenX + FlxG.width/2-30, this.screenY + FlxG.height/5, 300, 
					//"x: " + this.screenX + ", y: " + this.screenY);
				//add(this.debug);
				var enemyWidth:int = 15; // TODO: make this the enemy width and height.
				var enemyHeight:int = 15;
				this.removeEnemiesNotOnScreen(2 * enemyWidth, 2 * enemyHeight);

				var backgroundObjectWidth:int = 15;
				var backgroundObjectHeight:int = 15;
				
				//Randomly add background image
				if(Math.random() < 0.01){
					this.drawBackgroundObject(backgroundObjectHeight, backgroundObjectWidth);

				}
				if (Math.random() < 0.02) {
					//this.createEnemy(enemyWidth, enemyHeight);
				}
//				this.removeObjNotOnScreen(2*backgroundObjectHeight, 2*backgroundObjectWidth);
				this.display();
			}
			else{
				paused.update();
			}
			// Updating the health right now
			for (var i:int = 0; i < maxPlayerHealth; i ++) {
				this.remove(lifeimage[i]);
				lifeimage[i] = new FlxSprite(this.screenX + 220 + 20 * i, this.screenY + 220, heartImage); 
			}
			
			for(var k:int=tempPlayerHealth - 1; k >= 0; k--){
				this.add(lifeimage[k]);
			}
		}
		
		public function display():void {
			// TODO: more magic.
			this.player.display(this);
			for (var i:int = 0; i < this.enemyGroup.length; i++) {
				this.enemyGroup.members[i].display(this);
			}
		}
	}
}
