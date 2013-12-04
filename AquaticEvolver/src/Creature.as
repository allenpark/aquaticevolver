// ActionScript file
package {	
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Common.Math.b2Vec2;
	
	import org.flixel.FlxText;
	import Box2D.Collision.Shapes.b2PolygonShape;
	
	public class Creature extends B2FlxSprite {
		//public var x:int;
		//public var y:int;
		public var id:int;
		public var speed:Number;
		public var currentHealth:int;
		public var maxHealth:int;
		public var healthDisplay:FlxText;
		//public var adaptationGroup:FlxGroup;
		public var adaptations:Array;
		public var attackingWith:Adaptation; // null if not attacking right now.
		// Legal values of mode include:
		// "attacking", "running", "wandering". Change this.update() if this is changed. 
		public var mode:String;
		public var creatureType:Number;
		
		public function Creature(x:Number, y:Number, angle:Number=0, Graphic:Class=null, speed:Number=1, health:int=10, maxHealth:int=10,  width:Number=0, height:Number=0) {
			super(x,y, 0, Graphic, width, height);

			this.id = Math.random() * Number.MAX_VALUE;
			this.speed = speed;
			this.currentHealth = health;
			this.maxHealth = maxHealth;
			this.healthDisplay = new FlxText(0, 0, 50);
			this.healthDisplay.size = 7;
			this.attackingWith = null;
			//this.adaptationGroup = new FlxGroup();
			this.adaptations = new Array();
			this.creatureType = SpriteType.NEUTRAL;
		}
		
		public function addAdaptation(adapt:Adaptation):void {
			//this.adaptationGroup.add(adapt);
			this.adaptations.push(adapt);
			adapt.addToCreature(this);
		}
		
		public function removeAdaptation(adaptIndex:int):void {
			if (adaptIndex >= 0 && adaptIndex < this.adaptations.length) {
				var adapt:Adaptation = this.adaptations.splice(adaptIndex, 1)[0];
				adapt.removeFromCreature(this);
			}
		}
		
		// This method is called often to update the state of the creature.
		override public function update():void {
			var redColor = 0xffff0000;
			super.update();
			this.healthDisplay.x = this.x - 5;
			this.healthDisplay.y = this.y + 10;
			// added code for when the enemey current ratio of health 
			// is lower then the health threshold, it turns red
			var threshold = 0.5;
			var healthRatio = this.currentHealth * 1.0 / this.maxHealth;
			if (healthRatio <=threshold ) {
				this.fill(redColor);
			}
			this.healthDisplay.text = this.currentHealth + "/" + this.maxHealth;
			//			this.adaptationGroup.setAll("x", this.x + 10);

			//			this.adaptationGroup.setAll("y", this.y);			
			//for (var i:int = 0; i < this.adaptationGroup.length; i++) {
				//this.adaptationGroup.members[i].update();
			//}
			for (var i:int = 0; i < this.adaptations.length; i++) {
				this.adaptations[i].update();
			}
		}
		
		// Handling when one of your appendages collides with an enemy body.
		// Returns true iff the enemy has been killed.
		public function handleAttackOn(adaptation:Adaptation, enemy:Creature):Boolean {
			var enemyAlive:Boolean = false;
			if (adaptation == null) {
				enemyAlive = enemy.getAttacked(0);
			} else {
				enemyAlive = enemy.getAttacked(adaptation.attackDamage);	
			}
			
			if (!enemyAlive) {
				//this.inheritFrom(enemy);
				if (adaptation != null)	{
					adaptation.attackDamage += 2;					
				}
				return true;
			}
			return false;
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
			
			for each(var adaptation:Adaptation in adaptations){
				if (adaptation != null)
				{
					adaptation.kill();
				}
				else{
					trace("NULL ADAPTATION IN KILL");
				}
			}
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
			//return Adaptation(this.adaptationGroup.getRandom());
			return this.adaptations[Math.floor(Math.random() * this.adaptations.length)];
		}
		
		public function equals(creature:Creature):Boolean {
			return this.id == creature.id;
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withFriction(0.8)
				.withRestitution(0.3)
				.withDensity(0.7)
				.withLinearDamping(3.0)
				.withAngularDamping(30.0);
			return b2bb;
		}
	}
}
