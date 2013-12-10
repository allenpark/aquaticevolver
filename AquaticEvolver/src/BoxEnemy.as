package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import Collisions.AECollisionData;
	
	public class BoxEnemy extends Creature
	{
		public var aggroRadius:int = 200;
		private const BOUNDSBUFFER:int = 300;
		
		public function BoxEnemy(x:int, y:int, speed:Number, health:int, maxHealth:int, adaptations:Array) {
			super(x, y, 0, null, speed, health, maxHealth, width, height);
			this.attackingWith = null;
			
			this.maxVelocity.x = 80;
			this.maxVelocity.y = 80;
			this.drag.x = this.maxVelocity.x * 2;
			this.drag.y = this.maxVelocity.y * 2;
			this.creatureType = SpriteType.ENEMY;
		}
		
		/**
		 * The list of creatures, this is passed to an NPC creature's updateMovement function.
		 * -- Carlo Biedenharn - 11/12/2013
		 */
		static public var enemies:FlxGroup = new FlxGroup();
		
		/**
		 * The target that the creature is moving towards and therefore also attacking.
		 */
		private var target:FlxPoint = new FlxPoint(AEWorld.player.getX(), AEWorld.player.getY());
		
		/**
		 * Used to keep track of delays to make attacking discrete instead of continuous.
		 */
		public var counter:Number = 0;
		
		static public function generateBoxEnemy(newX:Number, newY:Number, defaultSpeed:Number, curHealth:Number, maxHealth:Number):BoxEnemy {
			var newEnemy:BoxEnemy = new BoxEnemy(newX, newY, defaultSpeed, curHealth, maxHealth, new Array());
			enemies.add(newEnemy);
			return newEnemy;
		}
		
		static public function getEnemiesLength():Number {
			return enemies.length;
		}
		
		override public function kill():void {
			/*
			for each (var adapt:Adaptation in adaptations) {
				adapt.kill();
			//adapt.destroy();
			}*/
			enemies.remove(this, true);
			super.kill();
		}
		
		private function getRandomAdaptations(adaptations:Array, maxPower:int):Array{
			var remainingValue:int = maxPower;
			var adaptArray:Array = new Array();
			
			//Selecting random adaptations while we still have power points remaining
			while(remainingValue > 0){
				var randomAdaptation:Adaptation = adaptations[Math.floor(Math.random() * adaptations.length)]; 
				adaptArray.push(randomAdaptation);
				//Subtracting the selected adaptation's "power" from the remaining value
				remainingValue -= (randomAdaptation.attackDamage + randomAdaptation.attackDamage);
			}
			
			return adaptArray;
		}
		
		override public function update():void {			
			super.update();
			counter += FlxG.elapsed;

			//FIX THESE BOUNDS!!
			var lowerYbound:Number = ((-BOUNDSBUFFER - FlxG.height/2) + AEWorld.player.getY());
			var upperYbound:Number = ((BOUNDSBUFFER + FlxG.height/2) + AEWorld.player.getY());
			var upperXbound:Number = ((BOUNDSBUFFER + FlxG.width/2) + AEWorld.player.getX());
			var lowerXbound:Number = ((-BOUNDSBUFFER - FlxG.width/2) + AEWorld.player.getX());
			
			//			FlxG.log("LX:"+lowerXbound+" ,UX:"+upperXbound+", LY:"+lowerYbound+" UY:"+upperYbound);
			//			FlxG.log('Bubble at:('+ this.x+","+this.y);
			//			
			var outsideYbounds:Boolean = this.y > upperYbound || this.y < lowerYbound;
			var outsideXbounds:Boolean = this.x > upperXbound || this.x < lowerXbound;
			//TODO: update this so that bubbles can still be slighly off screen
			//Make sure that the object is still on the screen
			if(outsideXbounds || outsideYbounds){
				this.destroy();
				this.kill();
				return
			}
			
			updateMove();
			aim(target);
			if (counter > 1) {
				attack(target);
				counter = 0;
			}
		}
		
		private function updateMove():void {
			var weakestIndex:int   = 0;
			var strongestIndex:int = 0;
			var weakestStrength:int   = 0;
			var strongestStrength:int = 0;
			var score:int;
			var seeSomething:Boolean = false;
			for (var i:int = 0; i < enemies.length; i++) {
				if (Math.sqrt(Math.pow(this.x - enemies.members[i].x, 2) +
					Math.pow(this.y - enemies.members[i].y, 2)) < aggroRadius) {
					seeSomething = true;
					score = enemies.members[i].getHealth() - this.getHealth();
					if (score < weakestStrength) {
						weakestIndex = i;
						weakestStrength = score;
					}
					if (score > strongestStrength) {
						strongestIndex = i;
						strongestStrength = score;
					}
				}
			}
			if (seeSomething) {
				this.moveCloseToEnemy(AEWorld.player, 240);
				target = new FlxPoint(AEWorld.player.x, AEWorld.player.y);
				//trace("PLAYER: (" + target.x + "," + target.y + ")");
				if (weakestStrength == 0) {
					//trace("RUN AWAY");
					//this.runAwayFromEnemy(enemies.members[strongestIndex]);
					//target = new FlxPoint(enemies.members[strongestIndex].x, enemies.members[strongestIndex].y);
					/*
					this.moveCloseToEnemy(AEWorld.player, 120);
					target = new FlxPoint(AEWorld.player.x, AEWorld.player.y);
					*/
				} else {
					//trace("MOVE TOWARDS");
					//this.moveTowardsEnemy(enemies.members[weakestIndex]);
					//target = new FlxPoint(enemies.members[weakestIndex].x, enemies.members[weakestIndex].y);
				}
			} else {
				//this.moveAround();
			}
		}
		
		
		private function runAwayFromEnemy(enemy:Creature):void {
			moveRelativeToEnemy(enemy, false);
		}
		
		private function moveTowardsEnemy(enemy:Creature):void {
			moveRelativeToEnemy(enemy, true);
		}
		
		private function moveRelativeToEnemy(enemy:Creature, towards:Boolean):void {
			var impulseSize:int = (towards) ? super.speed: -1*super.speed;
			var dirX:int = (enemy.x - this.x);
			var dirY:int = (enemy.y - this.y);
			var forceVec:b2Vec2 = getForceVec(dirX, dirY, impulseSize);
			body.ApplyImpulse(forceVec, body.GetPosition());
		}
		
		private function moveCloseToEnemy(enemy:AECreature, distance:Number):void {
			var impulseSize:int = super.speed;
			var distanceFromEnemy:int = Math.sqrt(Math.pow(this.x - enemy.x, 2) + Math.pow(this.y - enemy.y, 2));
			if (distanceFromEnemy < distance)
				impulseSize = -1*super.speed;
			// Non-ideal, but OK convergence.
			// I don't know if it's still called convergence though if we just zero out the amplitude at a point.
			if (Math.abs(distanceFromEnemy - distance) < 5) {
				impulseSize = 0;
			} else if (Math.abs(distanceFromEnemy - distance) < 20) {
				impulseSize = (impulseSize / super.speed);
			}
			var dirX:int = (enemy.x - this.x);
			var dirY:int = (enemy.y - this.y);
			var forceVec:b2Vec2 = getForceVec(dirX, dirY, impulseSize);
			body.ApplyImpulse(forceVec, body.GetPosition());
		}
		
		// Returns a vector in the (xDir, yDir) direction with a magnitude of impulseSize * 0.001.
		private function getForceVec(xDir:Number, yDir:Number, impulseSize:Number):b2Vec2 {
			var vec:b2Vec2 = new b2Vec2(xDir, yDir);
			vec.Normalize();
			vec.Multiply(impulseSize * 0.001);
			return vec;
		}
		
		public function moveAround():void {
			var randomX:Number = Math.random() * 2.0 - 1;
			var randomY:Number = Math.random() * 2.0 - 1;
			body.ApplyImpulse(getForceVec(randomX, randomY, super.speed), body.GetPosition());
		}
		
		private function attack(attackPoint:FlxPoint):void {
			for each (var adapt:Adaptation in adaptations) {
				adapt.attack(target);
			}
		}
		
		private function aim(attackPoint:FlxPoint):void {
			for each (var adapt:Adaptation in adaptations) {
				adapt.aim(target);
			}
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var bodyBuilder:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withData(new AECollisionData(this, SpriteType.ENEMY));
			return bodyBuilder;
		}
	}
}
