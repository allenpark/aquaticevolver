// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	
	import org.flixel.FlxGroup;
	
	// TODO: Fill in this class or reduce it to just a string.
	public class Adaptation extends FlxGroup {
		
		public var name:String;
		public var cost:int;
		public var isAttack:Boolean;
		public var attackDamage:int;
		public var speedBoost:int;
		public var healthBoost:int;
		
		public function Adaptation(name:String, cost:int, isAttack:Boolean, attackDamage:int) {
			super();
			this.name = name;
			this.cost = cost;
			this.isAttack = isAttack;
			if (!isAttack)
			{
				this.attackDamage = 0;
			} else {
				this.attackDamage = attackDamage
			}
			this.speedBoost = 0;
			this.healthBoost = 0;
		}

		// Use Creature.addAdaptation instead.
		public function addToCreature(creature:Creature):void {
			creature.currentHealth += this.healthBoost;
			creature.maxHealth += this.healthBoost;
			creature.speed += this.speedBoost;
		}
		
		// Use Creature.removeAdaptation instead.
		public function removeFromCreature(creature:Creature):void {
			creature.maxHealth -= this.healthBoost;
			creature.speed -= this.speedBoost;
		}
		
		override public function update():void {
			super.update();
		}
		
		public function convertToBox2D(pixelCoords:b2Vec2):b2Vec2 {
			var x:Number = AEWorld.b2NumFromFlxNum(pixelCoords.x);
			var y:Number = AEWorld.b2NumFromFlxNum(pixelCoords.y);
			var localPos:b2Vec2 = new b2Vec2(x,y);
			return localPos;
		}
	}
}
