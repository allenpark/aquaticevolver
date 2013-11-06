// ActionScript file

/**
 * Enemies class to be added to the world. Enemies will be randomly generated
 * and move around with some basic AI to interact with the world. 
 */ 
package{
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	
	public class Enemy extends Creature{
		
		[Embed(source='res/pacman.png')]
		public static var ImgPacman:Class;
		
		[Embed(source='res/ghost.png')]
		public static var ImgGhost:Class;
        
        var aggroRadius:int = 200;
		
		public function Enemy(x:int, y:int, speed:Number, health:int, maxHealth:int) {
			super(x, y, speed, health, maxHealth);
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

        public function updateMove(enemyGroup:FlxGroup):void {
            var weakestIndex:int   = 0;
            var strongestIndex:int = 0;
            var weakestStrength:int   = 0;
            var strongestStrength:int = 0;
            var score:int;
            var seeSomething:Boolean = false;
            for (var i:int = 0; i < enemyGroup.length; i++) {
                if (Math.sqrt(Math.pow(this.x - enemyGroup.members[i].x, 2) +
                              Math.pow(this.y - enemyGroup.members[i].y, 2)) < aggroRadius) {
                    seeSomething = true;
                    score = enemyGroup.members[i].health - this.health;
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
                this.runAwayFromEnemy(enemyGroup.members[weakestIndex]);
              } else {
                this.moveTowardsEnemy(enemyGroup.members[strongestIndex]);
              }
            } else {
              this.moveAround();
            }
        }
		
		public function runAwayFromEnemy(enemy:Creature):void{
			//this.loadGraphic(ImgPacman, true, true, 15, 14);
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
			//this.loadGraphic(ImgGhost, true, true, 15, 14);
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
	}
}
