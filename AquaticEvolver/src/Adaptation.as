// ActionScript file
package {
	import org.flixel.FlxSprite;

	public class Adaptation extends FlxSprite {
		[Embed(source='res/spike.png')]
		public static var spikeImg:Class;
		[Embed(source='res/tentacle.png')]
		public static var tentacleImg:Class;
		
		public var name:String;
		public var attackPower:int;
		public var isAttack:Boolean;
		public var attackDamage:int;

		public function Adaptation(name:String, x:int, y:int, angle:Number) {
			super(x,y);
			this.name = name;
			this.angle = angle;
			
			switch (name) {
				case "spike":
					loadGraphic(spikeImg, true, true, 32, 32);
					this.isAttack = true;
					this.attackDamage = 1;
					break;
				case "tentacle":
					loadGraphic(tentacleImg, true, true, 32, 32);
					this.isAttack = true;
					this.attackDamage = 1;
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
		
		public function setCoords(x:int, y:int):void {
			this.x = x;
			this.y = y;
		}
	}
}
