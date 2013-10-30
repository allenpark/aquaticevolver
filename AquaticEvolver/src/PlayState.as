package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public var player:FlxSprite;
		public var background:FlxSprite;
		
		[Embed(source='res/jump.mp3')]
		public static var Mp3Jump:Class;
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3366ff;
			
			//Create player (a red box)
			player = new FlxSprite(FlxG.width / 2 - 5);
			
			//LOADING GRAPHIC
			player.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			player.addAnimation("idle" /*name of animation*/, [0] /*used frames*/);
			player.addAnimation("walk", [0, 1, 2, 1], 5 /*frames per second*/);
			
			player.maxVelocity.x = 80;
			player.maxVelocity.y = 80;
			player.drag.x = player.maxVelocity.x * 2;
			player.drag.y = player.maxVelocity.y * 2;
			add(player);
		}
		
		override public function update():void
		{
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
			
			super.update();
			
			// FlxG.collide(level, player);
		}
	}
}