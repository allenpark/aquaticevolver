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
		
		public var aggroRadius:int = 200;
		
		public function BoxEnemy(x:int, y:int, speed:Number, health:int, maxHealth:int, adaptations:Array) {
			super(x, y, speed, health, maxHealth);
			this.attackingWith = null;
			
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			this.drag.x = this.maxVelocity.x * 2;
			this.drag.y = this.maxVelocity.y * 2;
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
			
			if (!this.onScreen(null))
			{
				this.kill();
				this.destroy();
			}
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
		override public function createBody():void
		{
			super.createBody();
			trace("enemy made");
		}
	}
}