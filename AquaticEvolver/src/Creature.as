// ActionScript file
package {	
	public class Creature {
		public var x:int;
		public var y:int;
		public var speed:Number;
		public var health:int;
		public var maxHealth:int;
		public var phenotypes:Array;
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
		}
		
		public function attack():void {
			// TODO: Decide if this method is necessary.
		}
		
		public function pickAttack():Phenotype {
			// TODO: Pick and return an attack.
			return null;
		}
		
		// This method is called often to update the state of the creature.
		public function update():void {
			switch (this.mode) {
				case "attacking":
					// TODO: Do stuff.
					break;
				case "running":
					// TODO: Do stuff.
					break;
				case "wandering":
					// TODO: Do stuff.
					break;
				default:
					// TODO: Throw a tantrum, because it shouldn't be here.
					break;
			}
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
			// TODO: Fill this in.
		}
		
		// Returns a random phenotype.
		public function selectTrait():Phenotype {
			return this.phenotypes[Math.floor(Math.random() * this.phenotypes.length)];
		}
	}
}
