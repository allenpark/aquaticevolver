package
{
	//Box2D imports
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class AEWorld extends FlxState
	{
		//Background music
		[Embed(source="res/DestinyOfADroplet.mp3")] public var droplet:Class;
		
		//Pausing
		public var paused:pausescreen;
		
		//Flx debugging
		FlxG.debug = true;
		/**
		 * Boolean to have the camera follow the player set to false
		 *if you don't want the camera to follow player
		 */
		private var FOLLOWINGPLAYER:Boolean = true;
		
		/**
		 * Boolean to spawn enemies
		 */
		private var SPAWNENEMIES:Boolean = true;
		
		/**
		 * The player character, sharing a common inherited ancestor as other NPC creatures.
		 * -- MRP - 11/11/2013
		 */
		public static var player:Creature;
		
		/**
		 * The box2D world, into which we must add all Box2D objects if
		 * we want them to be a part of the simulation that Box2D runs.
		 * -- Nick Benson - 10/28/2013
		 */
		public static var AEB2World:b2World;
		
		
		public static var collisionHandler:AECollisionListener;
		
		public static var debugStatement:FlxText;
		
		
		/**
		 * The pull of gravity. There is normal gravity underwater, but there are
		 * counter-active bouyancy effects. We'll need to fiddle with this number
		 * to get it to feel right. We should also treat this as a constant and
		 * only ever modify it HERE in the code.
		 * Remember, Box2D works in kilograms, meters, and seconds. This constant
		 * is in m / s^2.
		 * -- Nick Benson - 10/28/2013
		 */
		public var GRAVITY:b2Vec2 = new b2Vec2(0, 0);
		
		/**
		 * Ratio of pixel (flixel coordinates) to meter (box2d coordinates).
		 */
		private static const RATIO:Number = 100.0;
		
		/* We should probably refer to these as "cameraX", etc., unless it doesn't
		* actually mean what I think it means. -- Nick Benson - 10/28
		*/
		public static var ScreenX:int; // The x coordinate measured from the upper left corner of the screen.
		public static var ScreenY:int; // The y coordinate measured from the upper left corner of the screen.
		public static var ScreenWidth:int;
		public static var ScreenHeight:int;
		public var defaultHealth:int; //TODO: Should be in creature
		public var defaultSpeed:Number; //TODO: Should be in creature... also why int and not Number?
		
		/**
		 * During collision handling a body can't be killed because it may still be colliding with 
		 * other bodies. Therefore, during the world update we kill anything that should be dead
		 * with accordance to the previous step. Those creatures are stored in this list
		 * 
		 * - MARCEL 11/17/13
		 */
		public static var KILLLIST:Array = new Array();
		
		/**
		 * Constructs and initializes the Box2D b2World.
		 */
		private function createBox2DWorld():void {
			// Takes a gravity argument and a "doSleep" argument.
			// doSleep is a good thing. Look it up if you're considering
			// changing it. --Nick Benson - 10/28/2013
			collisionHandler = new AECollisionListener();
			AEB2World = new b2World(GRAVITY, true);
			AEB2World.SetContactListener(collisionHandler);
		}
		
		public static function flxAngleFromB2Angle(b2Angle:Number):Number
		{
			var flxAngle:Number = b2Angle * (180 / Math.PI);
			return flxAngle;
		}
		
		public static function flxXFromB2X(b2X:Number, b2Width:Number = 0):Number
		{
			var flxX:Number = ((b2X * RATIO) - b2Width/2.0);
			return flxX;
		}
		
		public static function flxYFromB2Y(b2Y:Number, b2Height:Number = 0):Number
		{
			var flxY:Number = ((b2Y * RATIO) - b2Height/2.0);
			return flxY;
		}
		
		public static function flxNumFromB2Num(b2Num:Number):Number
		{
			return b2Num * RATIO;
		}
		
		public static function b2NumFromFlxNum(flxNum:Number):Number
		{
			return flxNum / RATIO; // RATIO is a float, so no integer division
		}
		
		// Creates an enemy randomly slightly off screen.
		public function addOffscreenEnemy(xBuffer: int = 0, yBuffer: int = 0):void {
			var newX:Number;
			var newY:Number;
			if (Math.random() > 0.5) {
				// On the vertical edges.
				newX = (Math.random() > 0.5 ? -xBuffer : ScreenWidth) + ScreenX;
				newY = (Math.random() * (ScreenHeight + yBuffer) - yBuffer) + ScreenY;
			} else {
				// On the horizontal edges.
				newX = (Math.random() * (ScreenWidth + xBuffer) - xBuffer) + ScreenX;
				newY = (Math.random() > 0.5 ? -yBuffer : ScreenHeight) + ScreenY;	
			}
			var newEnemy:BoxEnemy = BoxEnemy.generateBoxEnemy(newX, newY, this.defaultSpeed, this.defaultHealth, this.defaultHealth);
			addCreature(newEnemy);
		}
		
		public function drawBackgroundObject(xBuffer:int = 0, yBuffer: int =0):void{
			var newX:Number;
			var newY:Number;
			
			//Randomly generating the distance that the image is seen from
			var viewDistance:Number = (Math.random()*5)+5.0;
			
//			var xBuffwithDistance:Number = xBuffer/viewDistance;
//			var yBuffwithDistance:Number = yBuffer/viewDistance;
			
			//Setting upper and lower bounds for the objects
			var lowerXbound:Number = -(ScreenWidth / 2) - xBuffer/2;
			var upperXbound:Number = (ScreenWidth / 2) - xBuffer/2;
			var lowerYbound:Number = -(ScreenHeight / 2) - yBuffer/2;
			var upperYbound:Number = (ScreenHeight / 2) - yBuffer/2;
			
			if(FOLLOWINGPLAYER){
				if (Math.random() > 0.5) {
					// On the vertical edges.
					newX = (Math.random() > 0.5 ? lowerXbound: upperXbound) + FlxG.camera.scroll.x;
					newY = (Math.random() * ScreenHeight)- ScreenHeight/2 + FlxG.camera.scroll.y;
				} else {
					// On the horizontal edges.
					newX = (Math.random() * ScreenWidth)- ScreenWidth/2 + FlxG.camera.scroll.x;
					newY = (Math.random() > 0.5 ? lowerYbound : upperYbound) + FlxG.camera.scroll.y;	
				}
			}else{
				newX = (Math.random() * (ScreenWidth-xBuffer/viewDistance));
				newY = (ScreenHeight-yBuffer/viewDistance);
			}
			
			var backgroundObject:BackgroundObject = new BackgroundObject(newX, newY, viewDistance);
			//Making the object float as it is a bubble right now
			backgroundObject.floatUpward();
			
			this.add(backgroundObject);
		}
		
		private function drawInitialBackgroundObjects():void{
			for(var i:int = 0; i<15; i++){
				var newX:Number;
				var newY:Number;
				// Randomly on the screen
				newX = (Math.random() * ScreenWidth)-ScreenWidth/2;
				newY = (Math.random() * ScreenHeight)-ScreenHeight/2;
				//Randomly generating the distance that the image is seen from
				var viewDistance:Number = Math.random()*5+5.0;
				
				var backgroundObject:BackgroundObject = new BackgroundObject(newX, newY, viewDistance);
				//Making the object float as it is a bubble right now
				backgroundObject.floatUpward();

				this.add(backgroundObject);
			}
		}
		
		private function addCreature(creature:Creature):void
		{
			this.add(creature);
			this.add(creature.healthDisplay);
		}
		
		private function setupDefaults():void
		{
			FlxG.bgColor = 0xff3366ff;
			ScreenX = FlxG.camera.scroll.x;
			ScreenY = FlxG.camera.scroll.y;
			ScreenWidth = FlxG.width;
			ScreenHeight = FlxG.height;
			this.defaultHealth = 10;
			this.defaultSpeed = .2;
		}
		
		private function initializePlayer():void
		{
			player = new Boxplayer(ScreenWidth / 2, ScreenHeight / 2, this.defaultSpeed * 2, this.defaultHealth, this.defaultHealth, new Array()); 
			//var start_adaptation : Adaptation = (new Spike(new b2Vec2(0, 0), 0, player));
			var start_adaptation : Adaptation = (new Tentacle(new b2Vec2(0, 0), 0, player));
			//var start_adaptation : Adaptation = (new Mandible(new b2Vec2(0, 0), 0, player));
			player.addAdaptation(start_adaptation);

			//Have the camera follow the player
			if (FOLLOWINGPLAYER) {
				FlxG.camera.follow(AEWorld.player);
			}
			this.add(start_adaptation);
		}
		
		private function initializeTestEnemy():BoxEnemy
		{
			return BoxEnemy.generateBoxEnemy(50, 50, this.defaultSpeed, this.defaultHealth, this.defaultHealth);
		}
		
		private  function setupB2Debug():void
		{
			var debugDrawing:DebugDraw = new DebugDraw();
			debugDrawing.debugDrawSetup(AEB2World, RATIO, 1.0, 1, 0.5);
		}
		
		private function setupFlxDebug():void
		{
			FlxG.watch(player, "x");
			FlxG.watch(player, "y");
			FlxG.watch(FlxG.camera.scroll, "x", "CameraX");
			FlxG.watch(FlxG.camera.scroll, "y", "CameraY");
		}
		
		private function setupPausing():void
		{
			FlxG.paused = false;
			paused = new pausescreen;
		}
		
		
		override public function create():void
		{
			super.create();
			setupDefaults();
			this.createBox2DWorld();	
			
			//Music
			FlxG.playMusic(droplet);
			
			//Pausing
			setupPausing();
			
			//Create player
			initializePlayer();
			addCreature(player);	
			
			//Test enemy
			if (SPAWNENEMIES)
			{
				var newEnemy:BoxEnemy = initializeTestEnemy();
				addCreature(newEnemy);
			}
			
			//Populating the world with some background objects
			drawInitialBackgroundObjects();
			
			//Debugging
			setupB2Debug();
			setupFlxDebug();
			
			debugStatement = new FlxText(300, 200, 100, ""); 
			this.add(debugStatement);
		}
		
		public static function toggleB2DebugDrawing():void
		{
			AquaticEvolver.box2dDebug = !AquaticEvolver.box2dDebug;
			AquaticEvolver.DEBUG_SPRITE.visible = AquaticEvolver.box2dDebug;
		}
		
		private function processKillList():void
		{
			while (KILLLIST.length>0)
			{
				//var top:Array = KILLLIST.pop();
				//var attacker:Boxplayer = top[0] as Boxplayer;
				//var enemy:Boxplayer = top[1] as Boxplayer;
				KILLLIST.pop().kill();
			}
		}
		
		override public function update():void 
		{
			if (!paused.showing) {		
				
				super.update();
				AEB2World.Step(1.0/60.0, 10, 10);
				processKillList();
				
				if (Math.random() < 0.02 && BoxEnemy.getEnemiesLength() < 30) {
					if (SPAWNENEMIES)
					{
						addOffscreenEnemy(15, 15);
					}
				}
				
				//Randomly add background image
				if(Math.random() < 0.1){
					drawBackgroundObject(128, 128);	
				}
				
				//Box2D debug stuff
				if (AquaticEvolver.box2dDebug) {
					
					AEB2World.DrawDebugData();
				}
				if(FlxG.keys.justPressed("D")){
					toggleB2DebugDrawing();
				}
				
				//TODO: We should revamp pausing... this isn't the best way of doing it, but it gets the job done for now
				if(FlxG.keys.justPressed("P")){
					paused = new pausescreen();
					paused.displayPaused();
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
