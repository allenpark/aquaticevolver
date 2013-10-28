// ActionScript file
package {	
	public class Creature {
		public var x:int;
		public var y:int;
		public var speed:Number;
		public var health:int;
		public var maxHealth:int;
		public var phenotypes:Array;
		public var attacks:Array;
		public var attackingWith:Phenotype; // null if not attacking right now.
		// Legal values of mode include:
		// "attacking", "running", "wandering". Change this.update() if this is changed. 
		public var mode:String;
		
		public function Creature(x:int, y:int, speed:Number, health:int, maxHealth:int, phenotypes:Array) {
			this.x = x;
			this.y = y;
			this.speed = speed;
			this.health = health;
			this.maxHealth = maxHealth;
			this.phenotypes = phenotypes;
			this.attacks = new Array();
			this.attackingWith = null;
			for (var i:int = 0; i < this.phenotypes.length; i++) {
				var phenotype:Phenotype = this.phenotypes[i];
				if (phenotype.isAttack()) {
					this.attacks.push(phenotype);
				}
			}
		}
		
		public function pickRandomAttack():Phenotype {
			return this.attacks[Math.floor(Math.random() * this.attacks.length)];
		}
		
		// This method is called often to update the state of the creature.
		public function update():void {
			switch (this.mode) {
				case "attacking":
					// TODO: Do stuff. ATTACK THY ENEMY!
					if (this.attackingWith != null) {
						this.attackingWith = this.pickRandomAttack();
						// TODO: start the animation of attacking somehow.
						// Actual attacking is done in this.handleAttackOn, to be a callback
						// upon a collision with an enemy body.
					}
					break;
				case "running":
					// TODO: Do stuff. Running away from an enemy.
					break;
				case "wandering":
					// TODO: Do stuff. Just swimming around.
					break;
				default:
					// TODO: Throw a tantrum, because it shouldn't be here.
					break;
			}
		}
		
		// Handling when one of your appendages collides with an enemy body.
		// Returns true iff the enemy has been killed.
		public function handleAttackOn(phenotype:Phenotype, enemy:Creature):Boolean {
			var enemyAlive:Boolean = enemy.getAttacked(phenotype.attackPower);
			if (!enemyAlive) {
				this.inheritFrom(enemy);
				return true;
			}
			return false;
		}
		
		public function display():void {
			// TODO: Make it be displayed somehow.
		}
		
		// Reduces the creature health by damage and returns whether the creature has died or not.
		public function getAttacked(damage:int):Boolean {
			this.health -= damage;
			if (this.health <= 0) {
				this.health = 0;
				return true;
			}
			return false;
		}
		
		public function alive():Boolean {
			return this.health > 0;
		}
		
		// The creature (this) will inherit a trait from the parameter creature. 
		public function inheritFrom(creature:Creature):void {
			var selectedTrait:Phenotype = creature.selectTrait();
			this.phenotypes.push(selectedTrait);
			if (selectedTrait.isAttack()) {
				this.attacks.push(selectedTrait);
			}
			
			// TODO: merge trait in the display somehow.
		}
		
		// Returns a random phenotype.
		public function selectTrait():Phenotype {
			return this.phenotypes[Math.floor(Math.random() * this.phenotypes.length)];
		}
	}
}
