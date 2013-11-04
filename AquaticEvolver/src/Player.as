package
{
	import org.flixel.FlxG;
	
	public class Player extends Creature
	{
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		[Embed(source="res/jump.mp3")] 	
		public var moveAction:Class;
		
		public function Player(x:int, y:int, speed:Number, health:int, maxHealth:int) {
			super(x, y, speed, health, maxHealth);
			
			//LOADING GRAPHIC
			this.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			this.addAnimation("idle", [0]);
			this.addAnimation("walk", [0, 1, 2, 1], 5);
		}
		
		override public function update():void
		{
			if (!FlxG.paused) {
				// FlxG.playMusic(droplet);
				// moving the player based on the arrow keys inputs
				this.acceleration.x = 0;
				if (FlxG.keys.LEFT && FlxG.keys.RIGHT)
					this.acceleration.x = 0;
				else if (FlxG.keys.LEFT)
					this.acceleration.x = -this.maxVelocity.x * 4;
				else if (FlxG.keys.RIGHT)
					this.acceleration.x = this.maxVelocity.x * 4;
				else
					this.acceleration.x = 0;
				
				if (FlxG.keys.UP && FlxG.keys.DOWN)
					this.acceleration.y = 0;
				else if (FlxG.keys.UP)
					this.acceleration.y = -this.maxVelocity.y * 4;
				else if (FlxG.keys.DOWN)
					this.acceleration.y = this.maxVelocity.y * 4;
				else
					this.acceleration.y = 0;
				
				// playing the correct animation
				if (FlxG.keys.LEFT ||FlxG.keys.RIGHT || FlxG.keys.UP || FlxG.keys.DOWN){
					this.play("walk");
					//FlxG.play(moveAction,0.5,false);
				}
					
				else
					this.play("idle");
				
				super.update();
			}
		}
	}
}