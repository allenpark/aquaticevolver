package
{
	
	//carlo version
	//Box2D imports
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class AEWorld extends FlxState
	{	
		/**
		 * Reference to the singleton instance of AEWorld
		 */
		public static var world:AEWorld;
		
		//Background music
		[Embed(source="res/Evolving Horizon.mp3")] public var droplet:Class;
		
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
		public static var player:AEPlayer;
		
		/**
		 * The box2D world, into which we must add all Box2D objects if
		 * we want them to be a part of the simulation that Box2D runs.
		 * -- Nick Benson - 10/28/2013
		 */
		public static var AEB2World:b2World;
		
		
		public static var collisionHandler:AECollisionListener;
		
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
		public var defaultSpeed:int;
		
		/**
		 * During collision handling a body can't be killed because it may still be colliding with 
		 * other bodies. Therefore, during the world update we kill anything that should be dead
		 * with accordance to the previous step. Those creatures are stored in this list
		 * 
		 * - MARCEL 11/17/13
		 */
		public static var KILLLIST:Array = new Array();
		
		/**
		 * Number keeping track of the last position the background's color
		 * was changed in order to figure out whether to change the background
		 * again or not
		 * -JAN 11/25/13
		 */
		private var prevBgChangePos:Number;
		
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
			
			//Setting upper and lower bounds for the objects
			var lowerXbound:Number = -(ScreenWidth / 2) - xBuffer - 50;
			var upperXbound:Number = (ScreenWidth / 2) + xBuffer + 50;
			var lowerYbound:Number = -(ScreenHeight / 2) - yBuffer - 50;
			var upperYbound:Number = (ScreenHeight / 2) + yBuffer + 50;
			
			
			if(FOLLOWINGPLAYER){
				if (Math.random()>.5) {
					// On the vertical edges.
					newX = (Math.random() > 0.5 ? lowerXbound: upperXbound) + player.getX();
					newY = (Math.random() * ScreenHeight)- ScreenHeight/2 + player.getY();
				} else {
					// On the horizontal edges.
					newX = (Math.random() * ScreenWidth) - ScreenWidth/2 + player.getX();
					newY = (Math.random() > 0.5 ? lowerYbound : upperYbound) + player.getY();	
				}
			}
			
			
			this.defaultHealth += 2
			var newEnemy:BoxEnemy = BoxEnemy.generateBoxEnemy(newX, newY, this.defaultSpeed,  this.defaultHealth, this.defaultHealth);
			var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.SPIKE, new b2Vec2(0, 0), 0, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.TENTACLE, new b2Vec2(0, 0), 0, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.MANDIBLE, new b2Vec2(0, 0), 0, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.BUBBLEGUN, new b2Vec2(0, 0), 0, newEnemy, this);
			newEnemy.addAdaptation(start_adaptation);
			addCreature(newEnemy);
			this.add(start_adaptation);
		}
		
		public function drawBackgroundObject(xBuffer:int = 0, yBuffer: int =0):void{
			var newX:Number;
			var newY:Number;
			
			//Randomly generating the distance that the image is seen from
			var viewDistance:Number = (Math.random()*5)+2.0;
			
			//Setting upper and lower bounds for the objects some what below what the
			//player can see so there is a consistent background
			var lowerXbound:Number = -(ScreenWidth / 2) - xBuffer/2 - 50;
			var upperXbound:Number = (ScreenWidth / 2) + xBuffer/2 + 50;
			var lowerYbound:Number = -(ScreenHeight / 2) - yBuffer/2 - 50;
			var upperYbound:Number = (ScreenHeight / 2) + yBuffer/2 + 50;
			
			if(FOLLOWINGPLAYER){
				if (Math.random()>.5) {
					// On the vertical edges.
					newX = (Math.random() > 0.5 ? lowerXbound: upperXbound) + player.getX();
					newY = (Math.random() * ScreenHeight)- ScreenHeight/2 + player.getY();
				} else {
					// On the horizontal edges.
					newX = (Math.random() * ScreenWidth) - ScreenWidth/2 + player.getX();
					newY = (Math.random() > 0.5 ? lowerYbound : upperYbound) + player.getY();	
				}
			}else{
				newX = (Math.random() * (ScreenWidth-xBuffer/viewDistance));
				newY = (ScreenHeight-yBuffer/viewDistance);
			}
			
			FlxG.log('Drawing background object at ' +newX+","+newY);
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
				newX = (Math.random() * ScreenWidth);
				newY = (Math.random() * ScreenHeight);
//				newX = player.x;
//				newY = player.y;
				
				//Randomly generating the distance that the image is seen from
				var viewDistance:Number = Math.random()*5+2;
				
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
			//Setting the background original changed position to be camera's original position
			prevBgChangePos = 0;
			//TODO: default health should be an attribute of creature, enemy, and/or player
			this.defaultHealth = 10;
		}
		
		private function initializePlayer():void
		{
			player = new AEPlayer(ScreenWidth/2.0,ScreenHeight/2.0); 

			
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.SPIKE, new b2Vec2(0, 0), 0, player);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.TENTACLE, new b2Vec2(0, 0), 0, player);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.MANDIBLE, new b2Vec2(0, 0), 0, player);

			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.BUBBLEGUN, new b2Vec2(0, 0), 0, player,this);
			//player.addAdaptation(start_adaptation);
			
			//Have the camera follow the player
			if (FOLLOWINGPLAYER) {
				FlxG.camera.follow(AEWorld.player.getFollowObject());
			}
			//this.add(start_adaptation);
			
		}
		
		private  function setupB2Debug():void
		{
			var debugDrawing:DebugDraw = new DebugDraw();
			debugDrawing.debugDrawSetup(AEB2World, RATIO, 1.0, 1, 0.5);
		}
		
		private function setupFlxDebug():void
		{
			FlxG.watch(player.getFollowObject().getBody().GetPosition(), "x", "x");
			FlxG.watch(player.getFollowObject().getBody().GetPosition(), "y", "y");
			FlxG.watch(FlxG.camera.scroll, "x", "CameraX");
			FlxG.watch(FlxG.camera.scroll, "y", "CameraY");
		}
		
		private function setupPausing():void
		{
			FlxG.paused = false;
			paused = new pausescreen;
		}
		
		public function getInstance():AEWorld
		{
			return this;
		}
		
		
		override public function create():void
		{
			AEWorld.world = this;
			super.create();
			setupDefaults();
			this.createBox2DWorld();	
			
			//Music
			FlxG.playMusic(droplet);
			
			//Pausing
			setupPausing();
			
			//Create player
			initializePlayer();
			//addCreature(player);	
			
			//Test enemy
			if (SPAWNENEMIES)
			{
				addOffscreenEnemy();
			}
			
			//Populating the world with some background objects
//			drawInitialBackgroundObjects();
			
			//Debugging
			setupB2Debug();
			setupFlxDebug();
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
				/*
				var top:Array = KILLLIST.pop();
				var attacker:Creature = top[0] as Creature;
				var enemy:Creature = top[1] as Creature;
				var adaptation:Adaptation = top[2] as Adaptation;
				var killedEnemy:Boolean = attacker.handleAttackOn(adaptation, enemy);
				*/
				break;
			}
		}
		
		override public function update():void 
		{
			super.update();
			if (!paused.showing) {
				player.update();
				AEB2World.Step(1.0/60.0, 10, 10);
				processKillList();
				
				if (SPAWNENEMIES)
				{
					if (Math.random() < 0.02 && BoxEnemy.getEnemiesLength() < 30) {
						addOffscreenEnemy(15, 15);
					}
				}
				
				//If the player has descended more than 100 pixels
				//from the last update, and the background is not 
				//completely black the background will get darker
				if((FlxG.camera.scroll.y > prevBgChangePos + 100) && (FlxG.bgColor.valueOf() > 0xff010206))
				{
					prevBgChangePos += 100;
					FlxG.bgColor -= 0x00010205;
//					FlxG.log("Darker Background is now"+ FlxG.bgColor.valueOf());
				}
				//If the player has gone up more than 100 pixels from the
				//last background change,and the background is not as
				//bright as it gets make the background brighter
				else if(FlxG.camera.scroll.y < prevBgChangePos - 100 && FlxG.bgColor.valueOf() < 0xff3366ff){
					prevBgChangePos -= 100;
					FlxG.bgColor += 0x00010205;
//					FlxG.log("Brighter Background is now"+ FlxG.bgColor.valueOf());

				}
				
				//Randomly add background image
//				if (Math.random() < 0.1) {
//					drawBackgroundObject(128, 128);	
//				}
				AquaticEvolver.DEBUG_SPRITE.x = - FlxG.camera.scroll.x;
				AquaticEvolver.DEBUG_SPRITE.y = - FlxG.camera.scroll.y;
				
				//Box2D debug stuff
				if (AquaticEvolver.box2dDebug) {
					AEB2World.DrawDebugData();
				}
				if (FlxG.keys.justPressed("D")) {
					toggleB2DebugDrawing();
				}
				
				
				//TODO: We should revamp pausing... this isn't the best way of doing it, but it gets the job done for now
				if (FlxG.keys.justPressed("P")) {
					paused = new pausescreen();
					paused.displayPaused();
					add(paused);		
					FlxG.music.pause();
				} 
				
				if (FlxG.keys.justPressed("G")) {
					FlxG.switchState(new GameOverState);				
				}
			}
			else {
				paused.update();
			}
		}
	}
}
