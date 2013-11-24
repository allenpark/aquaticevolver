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
		
		private var MAXSCROLLSPEED:int = 10;
		
		public function BackgroundObject(x:int , y:int, viewDistance:Number){
			
			this.loadGraphic(BubbleImg, false, false);
			
			this.viewDistance = viewDistance;
			
			//Setting background object's scroll factor for parallax scrolling
			this.scrollFactor.x = this.scrollFactor.y = 1.0/viewDistance;
			
			//Setting x and y coordinates based on the scroll factor to
			//accoounmt for the camera moving the object based on it's scroll factor
			this.x = x;
			this.y = y;
			
			//Adjusting the sprite's scale to appear smaller when further
			this.scale.x = this.scale.y = (Math.random()+1)*(1.0/viewDistance);
			
			this.alpha = 1.0/viewDistance;
		}
		
		override public function update():void{
			super.update();
			//FIX THESE BOUNDS!!
			var lowerYbound:Number = (-200 - FlxG.height/2) + AEWorld.player.y;
			var upperYbound:Number = (200 + FlxG.height/2) + AEWorld.player.y;
			var upperXbound:Number = (200 + FlxG.width/2) + AEWorld.player.x;
			var lowerXbound:Number = (-200 - FlxG.width/2) + AEWorld.player.x;
			
//			FlxG.log("LX:"+lowerXbound+" ,UX:"+upperXbound+", LY:"+lowerYbound+" UY:"+upperYbound);
//			FlxG.log('Bubble at:('+ this.x+","+this.y);
//			
			var outsideYbounds:Boolean = this.y > upperYbound || this.y < lowerYbound;
			var outsideXbounds:Boolean = this.x > upperXbound || this.x < lowerXbound;
			//TODO: update this so that bubbles can still be slighly off screen
			//Make sure that the object is still on the screen
			if(outsideXbounds || outsideYbounds){
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
			this.velocity.y = -Math.round(MAXSCROLLSPEED*this.viewDistance);
		}
	}
}