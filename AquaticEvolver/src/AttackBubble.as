package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class AttackBubble extends FlxSprite
	{
		[Embed(source='res/BackgroundBubble.png')]
		public static var ImgAttackBubble:Class;
		public function AttackBubble(x:int , y:int, xvelocity:Number, yvelocity:Number )
		{
			this.loadGraphic(ImgAttackBubble, false, false);
			this.x = x;
			this.y = y;
			this.velocity.x = xvelocity;
			this.velocity.y = yvelocity;
		}
		override public function update():void{
			super.update();
			var lowerYbound:Number = (-100 - FlxG.height/2)*this.scrollFactor.y + FlxG.camera.scroll.y;
			var upperYbound:Number = (100 + FlxG.height/2)*this.scrollFactor.y + FlxG.camera.scroll.y;
			var upperXbound:Number = (100 + FlxG.width/2)*this.scrollFactor.x + FlxG.camera.scroll.x;
			var lowerXbound:Number = (-100 - FlxG.width/2)*this.scrollFactor.x + FlxG.camera.scroll.x;
			
			var withInYbounds:Boolean = this.y < upperYbound && this.y > lowerYbound;
			var withInXbounds:Boolean = this.x < upperXbound && this.x > lowerXbound;
			//TODO: update this so that bubbles can still be slighly off screen
			//Make sure that the object is still on the screen
			if(!(withInXbounds && withInYbounds)){
				//CURRENTLY CRASHES GAME WHEN CALLED DON'T KNOW HOW TO CLEAN UP MEMORY
				//				this.destroy();
				this.kill(); 
			}
		}
		public function setXVelocity (xVelocity:Number){
			this.velocity.x = xVelocity;			
		}
		public function setYVelocity (yVelocity:Number){
			this.velocity.y = yVelocity;			
		}
		public function setXAcceleration (xAcceleration:Number){
			this.acceleration.x= xAcceleration;			
		}
		public function setYAcceleration (yAcceleration:Number){
			this.acceleration.y= yAcceleration;			
		}
		
	}
}