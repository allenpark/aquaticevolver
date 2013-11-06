package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class Player extends Creature
	{
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		[Embed(source="res/jump.mp3")] 	
		public var moveAction:Class;
		
		public function Player(state:FlxState, x:int, y:int, speed:Number, health:int, maxHealth:int) {
			super(state, x, y, speed, health, maxHealth);
			
			//LOADING GRAPHIC
			this.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			this.addAnimation("idle", [0]);
			this.addAnimation("walk", [0, 1, 2, 1], 5);
		}
		
		override public function update():void
		{
			super.update();
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
				if (FlxG.mouse.justPressed()){
					this.mode = "attacking";
					//Note this is hacked together and won't make sense if it uses a non-attacking adaptation, but I don't expect to use these for long
					//it might make sense to make a subclass of adaptations of attack class that defines how the different appendages attack
					this.attackingWith = this.adaptationGroup.members[0];
				}
				else if (FlxG.mouse.pressed() && this.attackingWith.name == "tentacle"){
					var dirX:int = (this.attackingWith.x - FlxG.mouse.x)
					var dirY:int = (this.attackingWith.y - FlxG.mouse.y)
					if (dirX < 0) {
						this.attackingWith.velocity.x = this.attackingWith.maxVelocity.x ;
					} else if (dirX > 0) {
						this.attackingWith.velocity.x = -this.attackingWith.maxVelocity.x ;
					} else {
						this.attackingWith.velocity.x = 0;
					}
					if (dirY < 0) {
						this.attackingWith.velocity.y = this.attackingWith.maxVelocity.y ;
					} else if (dirY > 0) {
						this.attackingWith.velocity.y = -this.attackingWith.maxVelocity.y ;
					} else {
						this.attackingWith.velocity.y = 0;
					}
				}
				else {
					this.mode = null;
				}
			
				// playing the correct animation
				if (FlxG.keys.LEFT ||FlxG.keys.RIGHT || FlxG.keys.UP || FlxG.keys.DOWN){
					this.play("walk");
					//FlxG.play(moveAction,0.5,false);
				}
					
				else
					this.play("idle");
			}
		}
	}
}