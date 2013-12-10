// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.AECreature;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	public class Adaptation extends FlxGroup {
		
		public var cost:int;
		public var isAttack:Boolean;
		public var attackDamage:int;
		public var speedBoost:int;
		public var healthBoost:int;
		public var creature:AECreature;
		public var adaptationType:Number;
		
		public function Adaptation(cost:int, isAttack:Boolean, attackDamage:int, creature:AECreature, adaptationType:Number) {
			super();
			this.cost = cost;
			this.isAttack = isAttack;
			if (!isAttack) {
				this.attackDamage = 0;
			} else {
				this.attackDamage = attackDamage
			}
			this.creature = creature;
			this.speedBoost = 0;
			this.healthBoost = 0;
			this.adaptationType = adaptationType;
		}
		
		public static function createAdaptationWithType(type:Number, creature:AECreature): Adaptation
		{
			var adaptation:Adaptation;
			
			switch (type)
			{
				case AdaptationType.HEALTHINCREASE:
//					FlxG.log("Creating a new health increase");
					adaptation = new HealthIncrease(creature);
					break;
				case AdaptationType.SPEEDINCREASE:
//					FlxG.log("Creating a new speed increase");
					adaptation = new SpeedIncrease(creature);
					break;
				default:
//					FlxG.log("Creating a new default health increase");
					adaptation = new HealthIncrease(creature);
					break;
			}
			return adaptation;
		}
		
		public function attack(point:FlxPoint):void {}
		public function aim(target:FlxPoint):void {}
		
		/*override public function kill():void {
		super.kill();
		
		
		}*/
		
		override public function update():void {
			super.update();
		}
		
		public function color(color:Number):void {}
	}
}
