// ActionScript file
package{

	import org.flixel.FlxSprite;
	
	/**
	 * Class representing the background elements of the game world.
	 */
	public class BackgroundObject extends FlxSprite{
		
		[Embed(source='res/BackgroundBubble.png')]
		public static var BubbleImg:Class;

		
		public function BackgroundObject(x:int , y:int, viewDistance:int){
			this.x = x;
			this.y = y;
			//Setting background object's scroll factor for parallax scrolling
			this.scrollFactor.x = 10*(1.0/viewDistance);
			this.scrollFactor.y = 10*(1.0/viewDistance);
			//Adjusting the sprite's scale to appear smaller when further
			this.scale.x = this.scale.y = 5*(1.0/viewDistance);
			
//			this.loadGraphic(BubbleImg);
			
			
		}
		
		
		public function moveAround():void{
			//Randomly move around
			this.acceleration.x = Math.random() * 100 - 50;
			this.acceleration.y = Math.random() * 100 - 50;
		}
		
		public function floatUpward():void{
			this.velocity.x = 0;
			this.velocity.y = 0;
		}
	}
}