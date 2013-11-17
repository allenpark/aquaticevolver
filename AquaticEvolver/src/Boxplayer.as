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
		
		private var defaultMovementScheme:Boolean = false; 
		
		public function Boxplayer(x:Number, y:Number,speed:Number, health:int, maxHealth:int, adaptations:Array) {
			super(x,y,ImgPlayer,speed,health, maxHealth, 14, 15);
			this.speed = speed;
			this.health = health;
			this.maxHealth = maxHealth;
			this.attackingWith = null;
			
			//LOADING GRAPHIC
			//this.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			this.addAnimation("idle", [0]);
			this.addAnimation("walk", [0, 1, 2, 1], 5);
		}
		
		override public function update():void {
			super.update();
			if (!FlxG.paused) {
				var xDir:Number = 0;
				var yDir:Number = 0;
				// moving the player based on the arrow keys inputs
				if (FlxG.keys.LEFT && FlxG.keys.RIGHT) {
				} else if (FlxG.keys.LEFT) {
//					trace("BoxPlayer: left");
					xDir = -1*this.speed;
				} else if (FlxG.keys.RIGHT) {
//					trace("BoxPlayer: right");
					xDir = 1*this.speed;
				}
					
				if (FlxG.keys.UP && FlxG.keys.DOWN)	{
				} else if (FlxG.keys.UP) {
//					trace("BoxPlayer: up");
					yDir = -1*this.speed;
				} else if (FlxG.keys.DOWN) {
//					trace("BoxPlayer: down");
					yDir = 1*this.speed;
				}
				
				// playing the correct animation
				if (FlxG.keys.LEFT ||FlxG.keys.RIGHT || FlxG.keys.UP || FlxG.keys.DOWN) {
					this.play("walk");
//					FlxG.play(moveAction,0.5,false);
				} else {
					this.play("idle");
				}
			
				if(defaultMovementScheme) {
					_obj.ApplyImpulse(getForceVec(xDir, yDir), _obj.GetPosition());					
				}
				else
				{
					var angle:int = _obj.GetAngle();
					var force:b2Vec2 = new b2Vec2(0.001 * Math.sin(angle) * yDir * -1, 0.001 * Math.cos(angle) * yDir);
					_obj.ApplyImpulse(force, _obj.GetPosition());
					var torque:int = 5;
					_obj.SetAngularVelocity(torque * xDir);
				}
			}
		}
		
		private function getForceVec(xDir:Number, yDir:Number):b2Vec2 {
			var vec:b2Vec2;
			if ( xDir != 0 && yDir != 0) {
				vec = new b2Vec2(xDir * 1/Math.sqrt(2), yDir * 1/Math.sqrt(2));
			} else {
				vec = new b2Vec2(xDir, yDir);
			}
			vec.Multiply(0.001);
			return vec;
		}
		/*
		override protected function bodyBuilder():B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder()
				.withFriction(0.8).withRestitution(0.3).withDensity(0.1)
				.withLinearDamping(10.0).withAngularDamping(40.0);
			return b2bb;
		}
		*/
	}
}