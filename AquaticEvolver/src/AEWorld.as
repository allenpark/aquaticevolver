package
{
	
	//carlo version
	//Box2D imports
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import Collisions.AEAttackDef;
	import Collisions.AECollisionListener;
	import Collisions.AEEvolutionDef;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import Collisions.AEHealthDef;

	
	public class AEWorld extends FlxState
	{
		/**
		 * Reference to the singleton instance of AEWorld
		 */
		public static var world:AEWorld;
		
		// music
		[Embed(source="res/Evolving Horizon.mp3")] public var droplet:Class;
		[Embed(source="res/Tailchasing.mp3")] public var battleMusic:Class;
		private var Flxdroplet:FlxSound = new  FlxSound();
		private var FlxbattleMusic:FlxSound = new FlxSound();
		

		
		[Embed(source="res/Cursor.png")] public var cursor:Class;

		
		//Image to enforce the barier at the top
		//[Embed (source = "res/BackgroundBubble.png")] public var enforcerImage:Class;
		
		[Embed (source="res/StreaksOfLight.png")] public var lightsImage:Class;
		private var lights:Array;
		
		//Pausing
		public var paused:pausescreen;
		
		//Flx debugging
		FlxG.debug = false;
		
		public static var debugText:FlxText;
		
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
		 * Drawing bubbles
		 */
		private var DRAWBUBBLES:Boolean = true;		
		
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
		public static var AttackList:Array = new Array();
		
		public static var RemoveList:Array = new Array();
		
		public static var EvolveList:Array = new Array();
		
		public static var HealthList:Array = new Array();
		
		/**
		 * Number keeping track of the last position the background's color
		 * was changed in order to figure out whether to change the background
		 * again or not
		 * -JAN 11/25/13
		 */
		private var prevBgChangePos:Number;
		
		/**
		 * Number of pixels necessary for the background to change brighness
		 * of the screen.
		 * -JAN 11/25/13
		 */
		private const PIXELSPERDEPTH:int = 100; //CHANGE THIS TO MAKE BACKGROUND CHANGE FASTER OR SLOWER
		/**
		 * Number keeping track of how much to change the different components
		 * RGB of the background
		 * -JAN 11/25/13
		 */
		
		private var redChange:int = 0;
		private var greenChange:int = 0;
		private var blueChange:int = 0;
		/**
		 * Y coordinate for the top of the world
		 * JTW 12/3/13
		 */
		public static var topLocation :Number = -10;
		
		/**
		 * Sound stuff, the safeDistance will be the distance at which the 
		 * battle music volume will go to zero. The battle music volume will 
		 * be a function of player's distance to nearest enemy. 
		 * JTW 12/9/13
		 */
		private var safeDistance : Number  = 700;
		private var battleVolume : Number = 0;
		public var playerInDanger:Boolean = false;
		
		
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
		//A function that will prevent the player from moving beyond the top
		private function enforceTop ():void {
			if (player.getY() < topLocation ){
				if (!player.aboveTop){
				//this.add(new FlxSprite(player.x - ScreenWidth/3,topLocation- ScreenHeight/2 - 30  ,enforcerImage));
				}
				player.goAboveTop();
			}
			else {
				player.goBelowTop();
			}
		}
		
		private function setupSound():void {
			Flxdroplet.loadEmbedded(droplet,true);
			FlxbattleMusic.loadEmbedded(battleMusic, true);
			Flxdroplet.play();
			FlxbattleMusic.play();
		}
		
		// Creates an enemy randomly slightly off screen.
		public function addOffscreenEnemy(xBuffer: int = 0, yBuffer: int = 0):void {
			var behave:String;
			var appen:int;
			var newX:Number;
			var newY:Number;
			
			//Setting upper and lower bounds for the objects
			var lowerXbound:Number = -(ScreenWidth / 2) - xBuffer - 100;
			var upperXbound:Number = (ScreenWidth / 2) + xBuffer + 100;
			var lowerYbound:Number = -(ScreenHeight / 2) - yBuffer - 100;
			var upperYbound:Number = (ScreenHeight / 2) + yBuffer + 100;
			
			
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
			
			//trace(newX + " " + newY);
			if(newY<=2000){
				behave = "passive";
				if(Math.random()>0.5){
					appen = 1;
				}
				else
					appen = 0;
			}
			
			else if(newY<=5000 && newY >2000){
				if(Math.random()>0.4){
					behave = "passive";
					
				}
				else{
					behave = "aggressive";
				}
				if(Math.random()>0.5){
					appen = 1;
				}
				else
					appen = 2;
			}
			else {
				
					behave = "aggressive";
					if(Math.random()>0.5){
						appen = 2;
					}
					else
						appen = 3;
				
			}
			
			this.defaultHealth += 2
			//Can't add enemies above the top bound
			if(newY > topLocation){
				var newEnemy:AEEnemy = AEEnemy.generateRandomEnemy(appen, behave, newX, newY);
				if (newEnemy)
				{
					this.add(newEnemy.healthDisplay);
				}
			}
			/*
			var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.SPIKE, new b2Vec2(0, 0), 0, newEnemy, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.TENTACLE, new b2Vec2(0, 0), 0, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.MANDIBLE, new b2Vec2(0, 0), 0, newEnemy);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.BUBBLEGUN, new b2Vec2(0, 0), 0, newEnemy, this);
			newEnemy.addAdaptation(start_adaptation);
			this.add(start_adaptation);
			*/

		}
		
		/**
		 * @param x X coordinate in flixel units
		 * @param y Y coordinate in flixel units
		 */
		public function outOfBufferBounds(x:Number, y:Number):Boolean
		{
			const BOUNDSBUFFER:int = 300;
			
			var lowerYbound:Number = ((-BOUNDSBUFFER - FlxG.height/2) + AEWorld.player.getY());
			var upperYbound:Number = ((BOUNDSBUFFER + FlxG.height/2) + AEWorld.player.getY());
			var upperXbound:Number = ((BOUNDSBUFFER + FlxG.width/2) + AEWorld.player.getX());
			var lowerXbound:Number = ((-BOUNDSBUFFER - FlxG.width/2) + AEWorld.player.getX());
			
			var outsideYbounds:Boolean = y > upperYbound || y < lowerYbound;
			var outsideXbounds:Boolean = x > upperXbound || x < lowerXbound;

			return outsideXbounds || outsideYbounds;

		}
		
		
		public function drawBackgroundObject(xBuffer:int = 0, yBuffer: int =0):void{
			var newX:Number;
			var newY:Number;
			
			//Randomly generating the distance that the image is seen from
			var viewDistance:Number = (Math.random()*5)+2.0;
			
			//Setting upper and lower bounds for the objects some what below what the
			//player can see so there is a consistent background
			var lowerXbound:Number = -((ScreenWidth / 1) - xBuffer/2 - 50)*viewDistance;
			var upperXbound:Number = ((ScreenWidth / 1) + xBuffer/2 + 50)*viewDistance;
			var lowerYbound:Number = -((ScreenHeight / 1) - yBuffer/2 - 50)*viewDistance;
			var upperYbound:Number = ((ScreenHeight / 1) + yBuffer/2 + 50)*viewDistance;
			
			if(FOLLOWINGPLAYER){
//				if (Math.random()>.5) {
//					// On the vertical edges.
//					newX = (Math.random() > 0.5 ? lowerXbound: upperXbound) + player.getX();
//					newY = (Math.random() * ScreenHeight)- ScreenHeight/2 + player.getY();
//				} else {
//					// On the horizontal edges.
//					newX = (Math.random() * ScreenWidth) - ScreenWidth/2 + player.getX();
//					newY = (Math.random() > 0.5 ? lowerYbound : upperYbound) + player.getY();	
//				}
				newX = (Math.random() * (ScreenWidth)) + player.getX();//-xBuffer/viewDistance));
				newY = (Math.random() * (ScreenHeight)) + player.getY();//-yBuffer/viewDistance));
			}else{
				newX = (Math.random() * (ScreenWidth-xBuffer/viewDistance));
				newY = (ScreenHeight-yBuffer/viewDistance);
			}
			
			if(newY > topLocation){
				//FlxG.log('Drawing background object at ' +newX+","+newY);
				var backgroundObject:BackgroundObject = new BackgroundObject(newX, newY, viewDistance);
				//Making the object float as it is a bubble right now
				backgroundObject.floatUpward();
				
				this.add(backgroundObject);
			}
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
			this.defaultSpeed = 1;
		}
		
		private function initializePlayer():void
		{
			player = new AEPlayer(ScreenWidth/2.0,ScreenHeight/2.0, 10);
			
			this.add(player.healthDisplay);

			
//			var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.SPIKE, new b2Vec2(0, 0), 0, player);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.TENTACLE, new b2Vec2(0, 0), 0, player);
			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.MANDIBLE, new b2Vec2(0, 0), 0, player);

			//var start_adaptation : Adaptation = Appendage.createAppendageWithType(AppendageType.BUBBLEGUN, new b2Vec2(0, 0), 0, player,this);
//			player.addAdaptation(start_adaptation);
			
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
		
		private function distanceToNearestEnemy():Number
		{
			var shortestDist: Number = 100000; 
			for each (var enemy:AEEnemy in AEEnemy.enemies){
				shortestDist = Math.min(shortestDist, FlxU.getDistance(new FlxPoint(player.getX(),player.getY()), new FlxPoint(enemy.getX(),enemy.getY())))
			}
			return shortestDist;
		}
		
		public function getInstance():AEWorld
		{
			return this;
		}
		 
		private function updateVolume():void
		{
			var distance:Number = distanceToNearestEnemy();
			if (!this.playerInDanger){
				battleVolume = 0;
				Flxdroplet.volume = 1;
			}
			else if (distance < safeDistance)
			{
				battleVolume = Math.min(1.3-distance/safeDistance, 1);  
			}
			else if (distance > safeDistance){
				this.playerInDanger = false;
			}
			Flxdroplet.volume = (1- battleVolume);
			FlxbattleMusic.volume = battleVolume;
			
			
		}
		
		
		override public function create():void
		{
			//FlxG.mouse.hide();
			FlxG.mouse.load(cursor, 1, -32, -32);
			//FlxG.mouse.show(cursor);
			
			AEWorld.world = this;
			super.create();
			setupDefaults();
			this.createBox2DWorld();	
			
			//Music
			setupSound();
			
			//Pausing
			setupPausing();
			
			//Create player
			initializePlayer();
			//addCreature(player);
			
			AEEnemy.enemies = new Array();
			
			//Debugging
//			setupB2Debug();
//			setupFlxDebug();
			AEWorld.debugText = new FlxText(50, 50, 100);
			this.add(AEWorld.debugText);
			
			lights = new Array();
			var numLights:Number = Math.ceil(FlxG.width / 1024.0) + 1;
			for (var i:Number = 0; i < numLights; i++) {
				var newLight:FlxSprite = new FlxSprite(0, topLocation - FlxG.height / 2, lightsImage); 
				lights.push(newLight);
				this.add(newLight);
			}
		}
		
		public static function toggleB2DebugDrawing():void
		{
			AquaticEvolver.box2dDebug = !AquaticEvolver.box2dDebug;
			AquaticEvolver.DEBUG_SPRITE.visible = AquaticEvolver.box2dDebug;
		}
		
		private function processLists():void
		{
			processEvolveList();
			processHealthList();
			processAttackList();
			processRemoveList();
		}
		
		private function processAttackList():void
		{
			while (AttackList.length>0)
			{
				var attackDef:AEAttackDef = AttackList.pop();
				handleAttack(attackDef);
			}
		}
		
		private function handleAttack(attackDef:AEAttackDef):void
		{
			//TODO: revamp attacking::dependent on relative angle/speed
			//TODO: detect player death in handle attack
			/*
			//Deal damage
			TENTACLEHEAD = speed/angle based
			SPIKE = speed/angle based
			MANDIBLEJAW = ???
			BUBBLE = constant
			SPIKESHOOTER
			*/		
			//trace("attackDef.attackAppendage" + attackDef.attackAppendage);
			if (attackDef.victim)
			{
				if(attackDef.attackAppendage)
				{
					attackDef.victim.takeDamage(attackDef.attackAppendage.attackDamage);
					
				}
				else
				{
					if (attackDef.attackType == SpriteType.BUBBLE)
					{
						var bubble:AttackBubble = (attackDef.attackB2FS as AttackBubble);
						attackDef.victim.takeDamage(bubble.attackDamage);
					}
					else if (attackDef.attackType == SpriteType.SPIKEBULLET)
					{
						var bullet:SpikeBullet = (attackDef.attackB2FS as SpikeBullet);
						attackDef.victim.takeDamage(bullet.attackDamage);
					}
				}
			}
		}
		
		private function relativeVelocity(v1:b2Vec2, v2:b2Vec2):b2Vec2
		{
			return new b2Vec2(v1.x - v2.x, v1.y - v2.y);
		}
		
		private function processRemoveList():void
		{
			while (RemoveList.length > 0)
			{
				RemoveList.pop().kill();
			}
		}
		private function processEvolveList():void
		{
			while (EvolveList.length > 0)
			{
				var evolutionDef:AEEvolutionDef = EvolveList.pop();
				var evolver:AECreature = evolutionDef.creature;
				var evolutionDrop:EvolutionDrop = evolutionDef.evolutionDrop;
				evolver.addAdaptation(evolutionDrop.adaptationType);
			}
		}
		
		private function processHealthList():void
		{
			while (HealthList.length > 0)
			{
				var healthDef:AEHealthDef = HealthList.pop();
				var creatureBeingHealed:AECreature = healthDef.creature;
				if (creatureBeingHealed.currentHealth < creatureBeingHealed.maxHealth) {
					var healthRegain:int = creatureBeingHealed.maxHealth - creatureBeingHealed.currentHealth;
					creatureBeingHealed.currentHealth += healthRegain;
				}
			}	
		}
		
		public function gameOver():void
		{
			AEEnemy.killAll();
			FlxG.switchState(new GameOverState);
		}
		override public function update():void 
		{
			var baseLightPos:Number = Math.floor(FlxG.camera.scroll.x / 1024) * 1024;
			for (var i:Number = 0; i < lights.length; i++) {
				lights[i].x = baseLightPos + 1024 * i;
			}
			if (player.getY() < topLocation) {
				FlxG.camera.follow(null);
				FlxG.camera.scroll.x = player.getX() - FlxG.width/2;
			} else {
				FlxG.camera.follow(AEWorld.player.getFollowObject());
			}
			if (!FlxG.paused) {
				AEWorld.debugText.x = FlxG.camera.scroll.x + 50;
				AEWorld.debugText.y = FlxG.camera.scroll.y + 50;
				super.update();
				player.update();
				AEEnemy.updateEnemies();
				updateVolume();
				FlxG.log("batt"+ FlxbattleMusic.volume);
				FlxG.log(Flxdroplet.volume);

				//Box2D debug stuff
				if (AquaticEvolver.box2dDebug) {
					AEB2World.DrawDebugData();
				}
				if (FlxG.keys.justPressed("I")) {
					toggleB2DebugDrawing();
				}
				AEB2World.Step(1.0/60.0, 10, 10);
				processLists();
				enforceTop();
				
				if (SPAWNENEMIES)
				{

					if (Math.random() < 0.01) {
						addOffscreenEnemy(15, 15);
					}
				}
				
				//If the player has descended more than PIXELSPERDEPTH pixels
				//from the last update, and the background is not 
				//completely black the background will get darker
				if((FlxG.camera.scroll.y > prevBgChangePos + PIXELSPERDEPTH) && (FlxG.bgColor.valueOf() > 0xff010206))
				{
					prevBgChangePos += PIXELSPERDEPTH;
					
					blueChange = (blueChange + 1)%5;
					//Reduce blue channel by one
					FlxG.bgColor -= 0x00000001;
					if (blueChange == 0 || blueChange == 2){
						greenChange = (greenChange + 1)%2;
						//Reduce red channel by one
						FlxG.bgColor -= 0x00000100;
						//TODO: perform bitshift operation here to assure that the hex has green channel
						if(greenChange == 0){
							//Reduce green channel by one
							FlxG.bgColor -= 0x00010000;
						}
					}
					//FlxG.log("Darker Background is now:"+FlxG.bgColor.valueOf().toString(16));

				}
				//If the player has gone up more than PIXELSPERDEPTH pixels from the
				//last background change,and the background is not as
				//bright as it gets make the background brighter
				else if(FlxG.camera.scroll.y < prevBgChangePos - PIXELSPERDEPTH && FlxG.bgColor.valueOf() < 0xff3265fe){
					prevBgChangePos -= PIXELSPERDEPTH;
					//Reduce blue channel by one
					FlxG.bgColor += 0x00000001;
					
					if ((blueChange == 0 || blueChange == 2)  ){
						//Reduce red channel by one
						FlxG.bgColor += 0x00000100;
						//TODO: perform bitshift operation here to assure that the hex has GREEN channel

						if(greenChange == 0){
							//Reduce green channel by one
							FlxG.bgColor += 0x00010000;
						}
						greenChange = (greenChange + 1)%2;
					}
					blueChange = (blueChange + 1)%5;
					//FlxG.log("Brighter Background is now:"+FlxG.bgColor.valueOf().toString(16));

				}
				
				//Randomly add background image
				if(DRAWBUBBLES){
					if (Math.random() < 0.02) {
						drawBackgroundObject(128, 128);	
					}
				}
				AquaticEvolver.DEBUG_SPRITE.x = - FlxG.camera.scroll.x;
				AquaticEvolver.DEBUG_SPRITE.y = - FlxG.camera.scroll.y;		
				
				if (FlxG.keys.justPressed("P")) {
					paused = new pausescreen();
					paused.displayPaused();
					add(paused);		
					FlxG.music.pause();
				} 
				
				if (FlxG.keys.justPressed("G")) {
					gameOver();
					
				}
				
				if (FlxG.keys.justPressed("K")) {
					AEEnemy.killAll();
				}
			}
			else {
				paused.update();
			}
		}
	}
}
