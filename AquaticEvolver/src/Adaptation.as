// ActionScript file
package {
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	// TODO: Fill in this class or reduce it to just a string.
	public class Adaptation extends FlxGroup {
		[Embed(source='res/spike.png')]
		public static var spikeImg:Class;
		[Embed(source='res/tentacle.png')]
		public static var tentacleTipImg:Class;
		[Embed(source='res/tentacle.png')]
		public static var tentacleJointImg:Class;
		
		public var name:String;
		public var attackPower:int;
		public var isAttack:Boolean;
		public var attackDamage:int;
		
		public var cost:int;
		
		public function Adaptation(name:String, x:int, y:int, angle:Number) {
			super();
			this.name = name;
			this.angle = angle;
			
			switch (name) {
				case "spike":
					this.add(new FlxSprite(x,y));
					
					FlxSprite sprite = new FlxSprite(x,y);
					sprite.loadGraphic(spikeImg, true, true, 32, 32);
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 20;
					break;
				case "tentacle":
					loadGraphic(tentacleImg, true, true, 32, 32);
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 50;
					break;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			// special update code goes in here
			switch (name) {
				case "spike":
					break;
				case "tentacle":
					break;
			}
		}
	}
}
