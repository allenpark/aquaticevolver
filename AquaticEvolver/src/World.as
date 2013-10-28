// ActionScript file
package {	
	public class World {
		public var player:Creature;
		public var enemies:Array;
		public var screenX:int; // The x coordinate of the upper left corner of the screen.
		public var screenY:int; // The y coordinate of the upper left corner of the screen.
		public var screenWidth:int;
		public var screenHeight:int;
		
		public function World()	{
			this.screenX = 0;
			this.screenY = 0;
			this.screenWidth = 500;
			this.screenHeight = 400;
			
			var playerPhenotypes:Array = new Array(); // TODO: fill this in.
			this.player = new Creature(this.screenWidth / 2, this.screenHeight / 2, 5.0, 10, 10, playerPhenotypes); 
			this.enemies = new Array();
		}
		
		// Creates an enemy randomly slightly off screen.
		public function createEnemy():void {
			// TODO: fill this in.
		}
		
		// Checks that all enemies are still on screen.
		public function checkEnemiesInScreen():void {
			var enemyXBuffer:int = 20;
			var enemyYBuffer:int = 20;
			for (var i:int = this.enemies.length - 1; i >= 0; i--) {
				var enemy:Creature = this.enemies[i];
				if (!this.inScreen(enemy.x, enemy.y, enemyXBuffer, enemyYBuffer)) {
					this.enemies.splice(i, 1);
				}
			}
		}
		
		// Returns if (x, y) are in the screen. Tolerates points xBuffer outside the x range and yBuffer 
		// outside the y range with defaults of xBuffer = 0 and yBuffer = 0.
		public function inScreen(x:int, y:int, xBuffer:int = 0, yBuffer:int = 0):Boolean {
			var inX:Boolean = x >= this.screenX - xBuffer && x < this.screenX + this.screenWidth + xBuffer;
			var inY:Boolean = y >= this.screenY - yBuffer && y < this.screenY + this.screenHeight + yBuffer;
			return inX && inY;
		}
		
		public function update() {
			// TODO: do magic.
			this.player.update();
			for (var i:int = 0; i < this.enemies.length; i++) {
				this.enemies[i].update();
			}
		}
		
		public function display() {
			// TODO: more magic.
			this.player.display();
			for (var i:int = 0; i < this.enemies.length; i++) {
				this.enemies[i].display();
			}
		}
	}
}
