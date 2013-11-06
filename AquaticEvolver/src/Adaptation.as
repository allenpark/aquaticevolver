// ActionScript file
package {
	import org.flixel.*;
	
	// TODO: Fill in this class or reduce it to just a string.
	public class Adaptation extends FlxGroup {
		
		[Embed(source='res/Spike1.png')]
		public static var spikeImg:Class;
		[Embed(source='res/tentacleHead1.png')]
		public static var tentacleHeadImg:Class;
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		
		public var name:String;
		public var attackPower:int;
		public var isAttack:Boolean;
		public var attackDamage:int;
		public var angle:Number;
		
		public var cost:int;
		
		private var sprite:FlxSprite;
		
		// constants
		private var tentacleSegments:int = 5;
		private var tentacleLength:int = 30;
		
		public function Adaptation(name:String, x:int, y:int, angle:Number) {
			super();
			this.name = name;
			this.angle = angle;
			
			switch (name) {
				case "spike":
					sprite = new FlxSprite(x,y);
					sprite.loadGraphic(spikeImg, true, true, 32, 128);
					sprite.angle = angle;
					this.add(sprite);
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 20;
					break;
				case "tentacle":
					var spriteX:Number = x;
					var spriteY:Number = y;
					var incX:Number = Math.cos(angle)*tentacleLength;
					var incY:Number = -Math.sin(angle)*tentacleLength;
					FlxG.log("incX " + incX);
					FlxG.log("incY " + incY);
					FlxG.log("spriteX " + spriteX);
					FlxG.log("spriteY " + spriteY);
					for (var i:int = 0; i < tentacleSegments-1; i++) {
						sprite = new FlxSprite(spriteX,spriteY);
						sprite.loadGraphic(tentacleMidImg, true, true, 32, 64);
						sprite.angle = angle;
						this.add(sprite);
						spriteX += incX;
						spriteY += incY;
						FlxG.log("spriteX " + spriteX);
						FlxG.log("spriteY " + spriteY);
					}
					sprite = new FlxSprite(spriteX,spriteY);
					sprite.loadGraphic(tentacleHeadImg, true, true, 32, 64);
					sprite.angle = angle;
					this.add(sprite);
					
					FlxG.log("tentacle length " + this.length);
					
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
