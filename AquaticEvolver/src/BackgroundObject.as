// ActionScript file
package{

	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * Class representing the background elements of the game world.
	 */
	public class BackgroundObject extends FlxSprite{
		
		[Embed(source='res/BackgroundBubble.png')]
		public static var BubbleImg:Class;
				
		private var viewDistance:int;
		
		private var MAXSCROLLSPEED:int = 150;
		
		public function BackgroundObject(x:int , y:int, viewDistance:Number){
			
			this.loadGraphic(BubbleImg, false, false);
			
			this.viewDistance = viewDistance;
			
			//Setting background object's scroll factor for parallax scrolling
			this.scrollFactor.x = 10*(1.0/viewDistance);
			this.scrollFactor.y = 10*(1.0/viewDistance);
			//Setting x and y coordinates based on the scroll factor to
			//accoounmt for the camera moving the object based on it's scroll factor
			this.x = (x*(this.scrollFactor.x))+FlxG.width/2;
			this.y = (y*(this.scrollFactor.y))+FlxG.height/2;
			
			//Adjusting the sprite's scale to appear smaller when further
			this.scale.x = this.scale.y = (Math.random()*5+1)*(1.0/viewDistance);
			
			this.alpha = 1.0/viewDistance;						
			
		}
		
		override public function update():void{
			super.update();
			//FIX THESE BOUNDS!!
			var lowerYbound:Number = (-100 - FlxG.height/2) + FlxG.camera.scroll.y;
			var upperYbound:Number = (100 + FlxG.height/2) + FlxG.camera.scroll.y;
			var upperXbound:Number = (100 + FlxG.width/2) + FlxG.camera.scroll.x;
			var lowerXbound:Number = (-100 - FlxG.width/2) + FlxG.camera.scroll.x;
			
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
		
		
		public function moveAround():void{
			//Randomly move around
			this.acceleration.x = Math.random() * 100 - 50;
			this.acceleration.y = Math.random() * 100 - 50;
		}
		
		public function floatUpward():void{
			this.velocity.x = 0;
			this.velocity.y = -Math.round(MAXSCROLLSPEED/this.viewDistance);
		}
	}
}