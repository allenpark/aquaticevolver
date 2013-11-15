// ActionScript file
package {	
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class Creature extends B2FlxSprite {
		//public var x:int;
		//public var y:int;
		public var id:int;
		public var speed:Number;
		public var currentHealth:int;
		public var maxHealth:int;
		public var healthDisplay:FlxText;
		public var adaptationGroup:FlxGroup;
		public var attackingWith:Adaptation; // null if not attacking right now.
		// Legal values of mode include:
		// "attacking", "running", "wandering". Change this.update() if this is changed. 
		public var mode:String;
		
		public function Creature(x:Number, y:Number, Graphic:Class=null, speed:Number=1, health:int=10, maxHealth:int=10,  width:Number=0, height:Number=0) {
			super(x,y,Graphic, width, height);

			this.id = Math.random() * Number.MAX_VALUE;
			this.speed = speed;
			this.currentHealth = health;
			this.maxHealth = maxHealth;
			this.healthDisplay = new FlxText(0, 0, 50);
			this.healthDisplay.size = 7;
			this.attackingWith = null;
			this.adaptationGroup = new FlxGroup();
		}
		
		public function addAdaptation(adapt:Adaptation):void {
			this.adaptationGroup.add(adapt);
		}
		
		// This method is called often to update the state of the creature.
		override public function update():void {
			//			this.adaptationGroup.setAll("x", this.x + 10);

			//			this.adaptationGroup.setAll("y", this.y);			
			for (var i:int = 0; i < this.adaptationGroup.length; i++) {
				this.adaptationGroup.members[i].update();
			}
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
			this.healthDisplay.x = this.x - 5;
			this.healthDisplay.y = this.y + 10;
			this.healthDisplay.text = this.currentHealth + "/" + this.maxHealth;
		}
		
		// Reduces the creature health by damage and returns whether the creature has died or not.
		public function getAttacked(damage:int):Boolean {
			this.currentHealth -= damage;
			if (this.currentHealth <= 0) {
				this.currentHealth = 0;
				this.kill();
				return true;
			}
			return false;
		}
		
		override public function kill():void {
			this.healthDisplay.kill();
			this.healthDisplay.destroy();
			super.kill();
		}
		
		public function isAlive():Boolean {
			return this.currentHealth > 0;
		}
		
		public function getHealth():int {
			return this.currentHealth;
		}
		
		// The creature (this) will inherit a trait from the parameter creature. 
		public function inheritFrom(creature:Creature):void {
			var selectedTrait:Adaptation = creature.selectTrait();
			this.addAdaptation(selectedTrait);
			
			// TODO: merge trait in the display somehow.
		}
		
		// Returns a random phenotype.
		public function selectTrait():Adaptation {
			return Adaptation(this.adaptationGroup.getRandom());
		}
		
		public function equals(creature:Creature):Boolean {
			return this.id == creature.id;
		}
		
		override protected function bodyBuilder():B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder()
				.withFriction(0.8).withRestitution(0.3).withDensity(0.7)
				.withLinearDamping(3.0).withAngularDamping(30.0);
			return b2bb;
		}
	}
}
