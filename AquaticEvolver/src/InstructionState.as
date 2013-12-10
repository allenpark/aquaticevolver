package
{
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class InstructionState extends AEWorld
	{
		[Embed (source = "res/mainmenu.png")] public var mainMenuImg:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;
		[Embed (source = "res/instructions.png")] public var instrucitonImg:Class;
		[Embed (source = "res/BubbleCannon1.png")] public var bubbleCannon:Class;
		[Embed (source = "res/Spike1.png")] public var spikeImg:Class;
		[Embed (source = "res/wasd-arrow.png")] public var movementKeysImg:Class;
		[Embed (source = "res/full_tentacle.png")] public var tentacleImg:Class;
		//ADD HEALTH DROP IMAGE HERE
		[Embed (source = "res/red-bubble.png")] public var healthDropImg:Class;
		//ADD POWERUP DROP IMAGE HERE
		[Embed(source="res/yellow-bubble.png")] public var powerUpDropImg:Class;
		
		[Embed (source = "res/player-movement.png")] public var playerMovementImg:Class;
		
		
		private var textScale:Number = 1.75;
		private var imageScale:Number = .5;
		private var textXOffset:Number = 350;
		private var yOffset:Number = 175;
		
		override public function create():void
		{
			
			super.create();
			player.kill(); 
			
			var currentYpos:int = 80;
			
			var instructions:FlxSprite = new FlxSprite(FlxG.width/2 - 65, currentYpos, instrucitonImg);
			add(instructions);
			
			currentYpos = yOffset;
			//Add health drop image here
//			var healthDropDesc:FlxText = new FlxText();
			
			var cannon:FlxSprite = new FlxSprite(90, currentYpos, bubbleCannon);
			cannon.scale.x = cannon.scale.y = imageScale;
			add(cannon);
			
			var cannonText:String = "-Aim and click the mouse to shoot projectiles from the cannon at your enemies";
			var cannonDesc:FlxText = new FlxText(cannon.width + textXOffset, currentYpos + cannon.height/2, FlxG.width - 300, cannonText);
			cannonDesc.scale.x = cannonDesc.scale.y = textScale;
			add(cannonDesc);
			
			var gameExplanationText:String = "Maneuver your way around the vastness of the ocean and defeat enemies to make yourself stronger. \n But be wary of delving too deep as you do not know what lurks beneath you.";
			var gameExplanation:FlxText = new FlxText(cannon.width + textXOffset, yOffset, FlxG.width - 300, gameExplanationText);
			gameExplanation.scale.x = gameExplanation.scale.y = textScale;
			add(gameExplanation);
			
			currentYpos += cannon.height/2;
			var spike:FlxSprite = new FlxSprite(135, currentYpos, spikeImg);
			spike.scale.x = spike.scale.y = imageScale;
			add(spike);
			
			var spikeText:String = "-When enemies begin to invade your personal space use your spikes to point enemies in the correct direction";
			var spikeDesc:FlxText = new FlxText(cannon.width + textXOffset, currentYpos + spike.height/2, FlxG.width - 300, spikeText);
			spikeDesc.scale.x = spikeDesc.scale.y = textScale;
			add(spikeDesc);
			
			currentYpos+=spike.height/2;
			//MAKE TENTACLE TO ADD HERE
			var tentacle:FlxSprite = new FlxSprite(120, currentYpos, tentacleImg);
			tentacle.scale.x = tentacle.scale.y = imageScale;
			add(tentacle);
			
			//Add tentacle height to the y position
			var tentacleText:String = "-Aim and click the mouse to swing your tentacle and attack enemies";
			var tentacleDesc:FlxText = new FlxText(cannon.width + textXOffset, currentYpos+tentacle.height/2, FlxG.width - 300, tentacleText);
			tentacleDesc.scale.x = tentacleDesc.scale.y = textScale;
			add(tentacleDesc);
			
			currentYpos += tentacle.height - 30;			
			var healthDrop:FlxSprite = new FlxSprite(125, currentYpos, healthDropImg);
			healthDrop.scale.x = healthDrop.scale.y = imageScale;
			add(healthDrop);
			
			var healthDropText:String = "-Be sure to replenish your health after fighting a tough enemy";
			var healthDropDesc:FlxText = new FlxText(cannon.width + textXOffset, currentYpos + healthDrop.height/2, FlxG.width - 300, healthDropText);
			healthDropDesc.scale.x = healthDropDesc.scale.y = textScale;
			add(healthDropDesc);
			
			currentYpos += healthDrop.height;
			var powerUpDrop:FlxSprite = new FlxSprite(125, currentYpos, powerUpDropImg);
			powerUpDrop.scale.x = powerUpDrop.scale.y = imageScale;
			add(powerUpDrop);
			
			var powerUpdropText:String = "-Killing enemies will allow you to pick up their abilities and strengthen your character";
			var powerUpDropDesc:FlxText = new FlxText(cannon.width + textXOffset, currentYpos + powerUpDrop.height/2, FlxG.width - 300, powerUpdropText);
			powerUpDropDesc.scale.x = powerUpDropDesc.scale.y = textScale;
			add(powerUpDropDesc) ;
			//Add images/description for movement here
			
			var movementText:String = "Use the w-a-s-d keys or arrow keys to maneuver your creature";
			var movementDesc:FlxText = new FlxText(FlxG.width/2 + 100, FlxG.height - 200, FlxG.width - 100, movementText);
			movementDesc.scale.x = movementDesc.scale.y = textScale;
			add(movementDesc);
			
			var movementKeys:FlxSprite = new FlxSprite(FlxG.width/2 - 125, FlxG.height - 150, movementKeysImg);
			add(movementKeys);
			
			var playerMovement:FlxSprite = new FlxSprite(FlxG.width/2+125, FlxG.height - 150, playerMovementImg);
			add(playerMovement);
			
			var menuButton:FlxButton = new FlxButton(FlxG.width/2 - 100, FlxG.height - 60, "", mainMenuCallback);
			menuButton.scrollFactor.x = menuButton.scrollFactor.y = 0 ;
			menuButton.loadGraphic(mainMenuImg);
			add(menuButton);	
			
			
		}
		public function mainMenuCallback():void{
			AEEnemy.killAll();
			FlxG.resetGame();
		}
	}
}