package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class FlashingLight extends FlxSprite
	{
		private var Graphic:Class; //TODO Add the graphic to display here
		/**
		 * Amount scale changes by when increasing or decreasing
		 */
		private const SCALEDELTA:Number = .1;
		/**
		 * Amount of time that will elapse before the image is updated
		 */
		private const TIMEBETWEENCHANGE:Number = .05;
		/**
		 * Max amount of scale that the image will reach before scaling down
		 */
		private const MAXSCALE:Number = 3;
		
		private var updateCounter:Number = 0;
		
		private var numOscillations:Number = 20;
		
		public function FlashingLight(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
		}
		
		override public function update():void{
			updateCounter += FlxG.elapsed;
			//TODO: Center on the player
			this.x = AEWorld.player.getX();
			this.y = AEWorld.player.getY();
			//Assure that we wait a certain amount of time before next
			//animation
			if(updateCounter > TIMEBETWEENCHANGE){
				updateCounter = 0;
				//We are less than the maximum size
				if(this.scale.x < MAXSCALE && numOscillations < 10){
					increaseScale();
					FlxG.log("Increased scale");
				}//Assure that we don't set scale to negative
				else if(this.scale.x > 2*SCALEDELTA){
					decreaseScale();
					FlxG.log("Decreased scale");
				}//Destroy the sprite once we are done with it
				else{
					FlxG.log("destroying object");
					this.kill();
					this.destroy();
				}
			}
			
		}
		
		public function increaseScale():void{
			this.scale.x += SCALEDELTA;
			this.scale.y += SCALEDELTA;
		}
		
		public function decreaseScale():void{
			this.scale.x -= SCALEDELTA;
			this.scale.y -= SCALEDELTA;
		}
	}
}