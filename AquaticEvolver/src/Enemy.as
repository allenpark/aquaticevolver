// ActionScript file

/**
 * Enemies class to be added to the world. Enemies will be randomly generated
 * and move around with some basic AI to interact with the world. 
 */ 
package{
	
	import org.flixel.FlxSprite;
	
	public class Enemy extends Creature{
		
		public function Enemy(x:int, y:int, speed:Number, health:int, maxHealth:int, adaptations:Array) {
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
		
		public function runAwayFromEnemy(enemy:Creature):void{
			//TODO Make enemies run away from a given creature if they are much more powerful than them
		}
		
		public function attackEnemy(enemy:Creature):void{
			//TODO Make enemies run towards enemies and attack them
		}
		
		public function moveAround():void{
			//TODO Make the enemy randomly move around if it's not chasing/attacking/running away from another enemy
		}
		
		override public function update():void
		{
			
		}
	}
}
