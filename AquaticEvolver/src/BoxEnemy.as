package
{
	import Box2D.Dynamics.b2World;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import org.flixel.*;
	
	import org.flixel.FlxG;

	public class BoxEnemy extends Creature
	{
		[Embed(source='res/pacman.png')]
		public static var ImgPacman:Class;
		
		[Embed(source='res/ghost.png')]
		public static var ImgGhost:Class;
		
		var aggroRadius:int = 200;
		
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
		
		public function BoxEnemy(state:FlxState, x:int, y:int, speed:Number, health:int, maxHealth:int, w:b2World) {
			super(state, x, y, speed, health, maxHealth);
			this.attackingWith = null;
			
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			this.drag.x = this.maxVelocity.x * 2;
			this.drag.y = this.maxVelocity.y * 2;
			
			this._world = w;
			this.createBody();
		}
		
		private function getRandomAdaptations(adaptations:Array, maxPower:int):Array{
			
			var remainingValue:int = maxPower;
			var adaptArray:Array = new Array();
			
			//Selecting random adaptations while we still have power points remaining
			while(remainingValue > 0){
				var randomAdaptation:Adaptation = adaptations[Math.floor(Math.random() * adaptations.length)]; 
				adaptArray.push(randomAdaptation);
				//Subtracting the selected adaptation's "power" from the remaining value
				remainingValue -= (randomAdaptation.attackDamage + randomAdaptation.attackPower);
			}
			
			return adaptArray;
		}
		
		override public function update():void {
			var weakestIndex:int   = 0;
			var strongestIndex:int = 0;
			var weakestStrength:int   = 0;
			var strongestStrength:int = 0;
			var score:int;
			var seeSomething:Boolean = false;
			/*for (var i:int = 0; i < enemies.length; i++) {
				if (Math.sqrt(Math.pow(this.x - enemies[i].x, 2) +
					Math.pow(this.y - enemies[i].y, 2)) < aggroRadius) {
					seeSomething = true;
					score = enemies[i].health - this.health;
					if (score < weakestStrength) {
						weakestIndex = i;
						weakestStrength = score;
					}
					if (score > strongestStrength) {
						strongestIndex = i;
						strongestStrength = score;
					}
				}
			}
			if (seeSomething) {
				if (weakestStrength == 0) {
					this.runAwayFromEnemy(enemies[weakestIndex]);
				} else {
					this.moveTowardsEnemy(enemies[strongestIndex]);
				}
			} else {
				this.moveAround();
			}*/
			//_obj.ApplyImpulse(getForceVec(xDir, yDir), _obj.GetPosition());
			x = ((_obj.GetPosition().x * World.RATIO) - width/2.0);
			y = ((_obj.GetPosition().y * World.RATIO) - height/2.0);
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
		}
		
		public function runAwayFromEnemy(enemy:Creature):void{
			this.loadGraphic(ImgPacman, true, true, 15, 14);
			var dirX:int = (enemy.x - this.x)
			var dirY:int = (enemy.y - this.y)
			if (dirX < 0) {
				this.acceleration.x = -this.maxVelocity.x * 4;
			} else if (dirX > 0) {
				this.acceleration.x = this.maxVelocity.x * 4;
			} else {
				this.acceleration.x = 0;
			}
			if (dirY < 0) {
				this.acceleration.y = -this.maxVelocity.y * 4;
			} else if (dirY > 0) {
				this.acceleration.y = this.maxVelocity.y * 4;
			} else {
				this.acceleration.y = 0;
			}
		}
		
		public function moveTowardsEnemy(enemy:Creature):void{
			this.loadGraphic(ImgGhost, true, true, 15, 14);
			var dirX:int = (enemy.x - this.x)
			var dirY:int = (enemy.y - this.y)
			if (dirX < 0) {
				this.acceleration.x = this.maxVelocity.x * 4;
			} else if (dirX > 0) {
				this.acceleration.x = -this.maxVelocity.x * 4;
			} else {
				this.acceleration.x = 0;
			}
			if (dirY < 0) {
				this.acceleration.y = this.maxVelocity.y * 4;
			} else if (dirY > 0) {
				this.acceleration.y = -this.maxVelocity.y * 4;
			} else {
				this.acceleration.y = 0;
			}
		}
		
		public function moveAround():void{
			//TODO Make the enemy randomly move around if it's not chasing/attacking/running away from another enemy
			this.acceleration.x = Math.random() * 600 - 300;
			this.acceleration.y = Math.random() * 600 - 300;
		}
		
		private function createBody():void
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