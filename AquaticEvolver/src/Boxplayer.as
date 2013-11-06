package
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import org.flixel.*;
	
	import org.flixel.FlxG;
	
	public class Boxplayer extends Creature
	{
		[Embed(source='res/player.png')]
		public static var ImgPlayer:Class;
		
		[Embed(source="res/jump.mp3")] 	
		public var moveAction:Class;
		
		////////////////////////      box2d traits      ///////////////////////////
		
		public var _fixDef:b2FixtureDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;
		
		private var _world:b2World;
		
		//Physics params default value
		public var _friction:Number = 0.8;
		public var _restitution:Number = 0.3;
		public var _density:Number = 0.7;
		
		//Default angle
		public var _angle:Number = 0;
		//Default body type
		public var _type:uint = b2Body.b2_dynamicBody;
		
		public function Boxplayer(x:int, y:int, speed:Number, health:int, maxHealth:int, adaptations:Array, w:b2World) {
			super();
			this.x = x;
			this.y = y;
			this.speed = speed;
			this.health = health;
			this.maxHealth = maxHealth;
			this.adaptations = adaptations;
			this.attacks = new Array();
			this.attackingWith = null;
			for (var i:int = 0; i < this.adaptations.length; i++) {
				var adaptation:Adaptation = this.adaptations[i];
				if (adaptation.isAttack) {
					this.attacks.push(adaptation);
				}
			}
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			this.drag.x = this.maxVelocity.x * 2;
			this.drag.y = this.maxVelocity.y * 2;
			
			//LOADING GRAPHIC
			this.loadGraphic(ImgPlayer, true, true, 14, 15);
			//SETTING ANIMATIONS
			this.addAnimation("idle", [0]);
			this.addAnimation("walk", [0, 1, 2, 1], 5);
			this._world = w;
			this.createBody();
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
					FlxG.play(moveAction,0.5,false);
					
				}
				else
					this.play("idle");
			
				_obj.ApplyImpulse(getForceVec(xDir, yDir), _obj.GetPosition());
				x = ((_obj.GetPosition().x * World.RATIO) - width/2.0);
				y = ((_obj.GetPosition().y * World.RATIO) - height/2.0);
				angle = _obj.GetAngle() * (180 / Math.PI);
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
		
		public function createBody():void
		{            
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox((width/2.0) / World.RATIO, (height/2.0) / World.RATIO);
			
			_fixDef = new b2FixtureDef();
			_fixDef.density = _density;
			_fixDef.restitution = _restitution;
			_fixDef.friction = _friction;                        
			_fixDef.shape = boxShape;
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((x + (width/2.0))/ World.RATIO, (y + (height/2.0)) / World.RATIO);
			_bodyDef.angle = _angle * (Math.PI / 180);
			_bodyDef.type = _type;
			
			_obj = _world.CreateBody(_bodyDef);
			_obj.CreateFixture(_fixDef);
			_obj.SetLinearDamping(3.0);
			
			FlxG.watch(_obj.GetPosition(), "x");
			FlxG.watch(_obj.GetPosition(), "y");
		}
	}
}