package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class Boxplayer extends Creature
	{
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		[Embed(source="res/jump.mp3")] 	
		public var moveAction:Class;
		
		public function Boxplayer(x:int, y:int, speed:Number, health:int, maxHealth:int, adaptations:Array) {
			super(x, y, speed, health, maxHealth);
			this.x = x;
			this.y = y;
			this.speed = speed;
			this.health = health;
			this.maxHealth = maxHealth;
			this.attackingWith = null;
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			this.drag.x = this.maxVelocity.x * 2;
			this.drag.y = this.maxVelocity.y * 2;
			
			//LOADING GRAPHIC
			this.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			this.addAnimation("idle", [0]);
			this.addAnimation("walk", [0, 1, 2, 1], 5);
		}
		override public function update():void
		{
			if (!FlxG.paused) {
				var xDir:Number = 0;
				var yDir:Number = 0;
				// moving the player based on the arrow keys inputs
				if (FlxG.keys.LEFT && FlxG.keys.RIGHT)
				{
					xDir = 0;
				}
					
				else if (FlxG.keys.LEFT)
				{
					trace("BoxPlayer: left");
					xDir = -1;
				}
				else if (FlxG.keys.RIGHT)
				{
					trace("BoxPlayer: right");
					xDir = 1;
				}
				else
				{
					xDir = 0;
				}
					
				if (FlxG.keys.UP && FlxG.keys.DOWN)
				{
					yDir = 0;
				}
				else if (FlxG.keys.UP)
				{
					trace("BoxPlayer: up");
					yDir = -1;
				}
				else if (FlxG.keys.DOWN)
				{
					trace("BoxPlayer: down");
					yDir = 1;
				}
				else
					yDir = 0;
				
				
				// playing the correct animation
				if (FlxG.keys.LEFT ||FlxG.keys.RIGHT || FlxG.keys.UP || FlxG.keys.DOWN){
					this.play("walk");
//					FlxG.play(moveAction,0.5,false);
					
				}
				else
					this.play("idle");
			
				_obj.ApplyImpulse(getForceVec(xDir, yDir), _obj.GetPosition());
				super.update();
			}
		}
		
		private function getForceVec(xDir:Number, yDir:Number):b2Vec2
		{
			var vec:b2Vec2;
			if ( xDir != 0 && yDir != 0)
			{
				vec = new b2Vec2(xDir * 1/Math.sqrt(2), yDir * 1/Math.sqrt(2));
			}
			else
			{
				vec = new b2Vec2(xDir, yDir);
			}
			vec.Multiply(0.001);
			return vec;
		}
	}
}