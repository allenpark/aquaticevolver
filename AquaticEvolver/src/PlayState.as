package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public var player:FlxSprite;
		public var paused:Boolean;
		public var pauseGroup:FlxGroup;
		
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3366ff;
			FlxG.paused = false;
			pauseGroup = new FlxGroup();
			
			//Create player (a red box)
			player = new FlxSprite(FlxG.width / 2, FlxG.height/2);
			
			//LOADING GRAPHIC
			player.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			player.addAnimation("idle", [0]);
			player.addAnimation("walk", [0, 1, 2, 1], 5);
			
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 80;
			player.drag.x = player.maxVelocity.x * 2;
			player.drag.y = player.maxVelocity.y * 2;
			add(player);
		}
		
		override public function update():void
		{
			if(!FlxG.paused){
				// moving the player based on the arrow keys inputs
				player.acceleration.x = 0;
				if (FlxG.keys.LEFT && FlxG.keys.RIGHT)
					player.acceleration.x = 0;
				else if (FlxG.keys.LEFT)
					player.acceleration.x = -player.maxVelocity.x * 4;
				else if (FlxG.keys.RIGHT)
					player.acceleration.x = player.maxVelocity.x * 4;
				else
					player.acceleration.x = 0;
				
				if (FlxG.keys.UP && FlxG.keys.DOWN)
					player.acceleration.y = 0;
				else if (FlxG.keys.UP)
					player.acceleration.y = -player.maxVelocity.y * 4;
				else if (FlxG.keys.DOWN)
					player.acceleration.y = player.maxVelocity.y * 4;
				else
					player.acceleration.y = 0;
				
				// playing the correct animation
				if (FlxG.keys.LEFT ||FlxG.keys.RIGHT || FlxG.keys.UP || FlxG.keys.DOWN)
					player.play("walk");
				else
					player.play("idle");
				
				super.update();
			}
			else{
				pauseGroup.update();
			}
			
			if(FlxG.keys.justPressed("P")){
				if(!FlxG.paused){
					FlxG.paused = true;
					pauseGroup.revive();
				} 
				else {
					FlxG.paused = false;
					pauseGroup.alive = false;
					pauseGroup.exists = false;
				}
			}
		}
	}
}