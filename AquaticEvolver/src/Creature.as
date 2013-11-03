// ActionScript file
package {	
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class Creature extends FlxSprite {
		//public var x:int;
		//public var y:int;
		public var speed:Number;
		public var currentHealth:int;
		public var maxHealth:int;
		public var healthDisplay:FlxText;
		public var adaptations:Array;
		public var attacks:Array;
		public var attackingWith:Adaptation; // null if not attacking right now.
		// Legal values of mode include:
		// "attacking", "running", "wandering". Change this.update() if this is changed. 
		public var mode:String;
		
		public function Creature(x:int=0, y:int=0, speed:Number=1, health:int=10, maxHealth:int=10, adaptations:Array=undefined) {
			this.x = x;
			this.y = y;
			this.speed = speed;
			this.currentHealth = health;
			this.maxHealth = maxHealth;
			this.healthDisplay = new FlxText(0, 0, 1);
			this.attacks = new Array();
			this.attackingWith = null;
			this.adaptations = adaptations || new Array();
			for (var i:int = 0; i < this.adaptations.length; i++) {
				if (this.adaptations[i].isAttack) {
					this.attacks.push(this.adaptations[i]);
				}
			}
		}
		
		public function addAdaptation(adapt:Adaptation):void {
			this.adaptations.push(adapt);
			if (adapt.isAttack) {
				this.attacks.push(adapt);
			}
		}
		
		public function pickRandomAttack():Adaptation {
			return this.attacks[Math.floor(Math.random() * this.attacks.length)];
		}
		
		// This method is called often to update the state of the creature.
		override public function update():void {
			super.update();
		}
		
		// Handling when one of your appendages collides with an enemy body.
		// Returns true iff the enemy has been killed.
		public function handleAttackOn(phenotype:Adaptation, enemy:Creature):Boolean {
			var enemyAlive:Boolean = enemy.getAttacked(phenotype.attackPower);
			if (!enemyAlive) {
				this.inheritFrom(enemy);
				return true;
			}
			return false;
		}
		
		public function display(state:FlxState):void {
			// TODO: Make it be displayed somehow.
			this.healthDisplay.kill();
			this.healthDisplay = new FlxText(this.x - 5, this.y + 10, 50, this.currentHealth + "/" + this.maxHealth);
			this.healthDisplay.size = 7;
			state.add(this.healthDisplay);
		}
		
		// Reduces the creature health by damage and returns whether the creature has died or not.
		public function getAttacked(damage:int):Boolean {
			this.currentHealth -= damage;
			if (this.currentHealth <= 0) {
				this.currentHealth = 0;
				return true;
			}
			return false;
		}
		
		public function isAlive():Boolean {
			return this.currentHealth > 0;
		}
		
		// The creature (this) will inherit a trait from the parameter creature. 
		public function inheritFrom(creature:Creature):void {
			var selectedTrait:Adaptation = creature.selectTrait();
			this.addAdaptation(selectedTrait);
			
			// TODO: merge trait in the display somehow.
		}
		
		// Returns a random phenotype.
		public function selectTrait():Adaptation {
			return this.adaptations[Math.floor(Math.random() * this.adaptations.length)];
		}
	}
}
