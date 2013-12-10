package
{	
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;
	
	import Creature.Def.AEHeadDef;
	import Creature.Def.AETailDef;
	import Creature.Def.AETorsoDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class AEEnemy extends AECreature
	{

		public static var enemies:Array;
		
		/**
		 * The target that the creature is moving towards and therefore also attacking.
		 */
		private var target:FlxPoint = new FlxPoint(AEWorld.player.getX(), AEWorld.player.getY());
        private var counter:Number = 0;
		public var aggroRadius:int = 200;
		private var movementBody:b2Body;
		
		private var attitude:String;
		private var original:FlxPoint;
		private var current:FlxPoint;
		private var boxBound:int = Math.random()*300+50;
		
		private var distTraveled:Number = 0;
		
		private static var unusedIDs:Array = new Array(2,3,4,5,6);
		
		private var _id:Number;
		
		public function AEEnemy(id:Number, appen:int, behavior:String, x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			_id = id;
			super(x, y, health, headDef, torsoDef, tailDef);
			this.original = new FlxPoint(getX(), getY());
			this.current  = new FlxPoint(original.x + boxBound, original.y);
			/*
			if(Math.random() > 0.8){
				attitude = "Aggressive";
			}
			*/
			attitude = 'aggressive';
			trace("app " + appen);
			var z:Number = Math.random();
			if (appen == 1) {
				if(z>0.5){
					addAdaptation(AdaptationType.TENTACLE);
				} else {
					addAdaptation(AdaptationType.SPIKE);
				}
			}
			if (appen == 2) {
				if (z<0.33) {
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.SPIKE);
				} else if (z>=0.33 && z<0.66){
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.BUBBLEGUN);
					//addAdaptation(AdaptationType.SPIKE);
				} else{
					addAdaptation(AdaptationType.MANDIBLE);
					addAdaptation(AdaptationType.SPIKESHOOTER);
					//addAdaptation(AdaptationType.SPIKE);
					//addAdaptation(AdaptationType.SPIKE);

				}
			}
			if (appen == 3) {
				if (z<0.2) {
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.SPIKE);
					addAdaptation(AdaptationType.CLAW);
				} else if (z>=0.2 && z<0.4) {
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.BUBBLEGUN);
					addAdaptation(AdaptationType.SPIKESHOOTER);
					//addAdaptation(AdaptationType.SPIKE);
					//addAdaptation(AdaptationType.SPIKE);
				} else if (z>=0.4 && z<0.6) {
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.BUBBLEGUN);
					//addAdaptation(AdaptationType.SPIKE);
					addAdaptation(AdaptationType.MANDIBLE);
					//addAdaptation(AdaptationType.SPIKE);

				} else if (z>=0.6 && z<0.8) {
					addAdaptation(AdaptationType.TENTACLE);
					addAdaptation(AdaptationType.SPIKESHOOTER);
					//addAdaptation(AdaptationType.SPIKE);
					addAdaptation(AdaptationType.MANDIBLE);
					//addAdaptation(AdaptationType.SPIKE);
				} else {
					addAdaptation(AdaptationType.CLAW);
					addAdaptation(AdaptationType.BUBBLEGUN);
					//addAdaptation(AdaptationType.SPIKE);
					addAdaptation(AdaptationType.SHELL);
				}
			}
		}
		
		public static function generateRandomEnemy(app:int, behavior:String, x:Number, y:Number):AEEnemy
		{
			var headDef:AEHeadDef = AECreature.randomHeadDef(x,y);
			var torsoDef:AETorsoDef = AECreature.randomTorsoDef(x,y);
			var tailDef:AETailDef = AECreature.randomTailDef(x,y);
			return generateEnemy(app, behavior, x, y, headDef, torsoDef, tailDef);
		}
		
		/**
		 * @param x In flixel coords
		 * @param y In flixel coords
		 */
		public static function generateEnemy(app:int, behavior:String, x:Number, y:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef):AEEnemy
		{
			if (unusedIDs.length != 0)
			{
				var id:Number = unusedIDs.pop();
				var newEnemy:AEEnemy = new AEEnemy(id, app,  behavior, x, y, 10, headDef, torsoDef, tailDef);
				enemies.push(newEnemy);
				return newEnemy;
			} else {
				for each (var enemy:AEEnemy in enemies)
				{
					if (AEWorld.world.outOfBufferBounds(enemy.getX(), enemy.getY()))
					{
						trace("enemy out of bounds killed");
						enemy.kill();
						// try again
						return generateEnemy(app, behavior, x,y, headDef, torsoDef, tailDef);
					}
				}
				return null;
			}
		}
		
		override public function getID():Number
		{
			return _id;
		}
		
		override public function update():void{		
			super.update();
			counter += FlxG.elapsed;
			this.movementBody = this._head.headSegment.getBody();
			if (attitude == "passive") {
				passiveMovement();
			} else {
				aggressiveMovement();
			}
		}
		
		override public function kill():void
		{
			if (this.killed) {
				return;
			}
			unusedIDs.push(_id);

			AEEnemy.enemies.splice(AEEnemy.enemies.indexOf(this),1);
			super.kill();
        }
		
		public static function killAll():void {
			while (AEEnemy.enemies.length > 0) {
				AEWorld.debugText.text += " " + AEEnemy.enemies[0].getID();
				AEEnemy.enemies[0].kill();
			}
		}

		public static function updateEnemies():void {
			for each (var enemy:AEEnemy in AEEnemy.enemies) {
				enemy.update();
				FlxG.log(unusedIDs);
			}
		}

		private function aggressiveMovement():void {
			
			this.moveCloseToEnemy(AEWorld.player, 240);
			target = new FlxPoint(FlxG.width  / 2.0, FlxG.height / 2.0);
			aim(target);
			if (counter > 1) {
				counter = 0;
				attack(target);
			}
		}
		
		private function runAwayFromEnemy(enemy:AECreature):void {
			moveRelativeToEnemy(enemy, false);
		}
		
		private function moveTowardsEnemy(enemy:AECreature):void {
			moveRelativeToEnemy(enemy, true);
		}
		
		private function moveRelativeToEnemy(enemy:AECreature, towards:Boolean):void {
			var impulseSize:int = (towards) ? super.speed: -1*super.speed;
			var dirX:int = (enemy.getX() - this.getX());
			var dirY:int = (enemy.getY() - this.getY());
			var forceVec:b2Vec2 = getForceVec(dirX, dirY, impulseSize);
			
			var headAngle:Number = movementBody.GetAngle();
			var headDirection:b2Vec2 = new b2Vec2(Math.sin(headAngle) * -1, Math.cos(headAngle));
			var goalDirection:b2Vec2 = new b2Vec2(dirX, dirY);
			var cross:Number = b2Math.CrossVV(headDirection, goalDirection);
			
			var torque:Number = 5;
			if (cross > 0) {
				movementBody.SetAngularVelocity(-1 * torque);
			} else {
				movementBody.SetAngularVelocity(torque);
			}

			
			this.movementBody.ApplyImpulse(forceVec, this.movementBody.GetPosition());
		}
		
		private function moveCloseToEnemy(enemy:AECreature, distance:Number):void {
			var impulseSize:int = super.speed;
			var distanceFromEnemy:int = Math.sqrt(Math.pow(this.getX() - enemy.getX(), 2) + Math.pow(this.getY() - enemy.getY(), 2));
			if (distanceFromEnemy < distance)
				impulseSize = -1*super.speed;
			// Non-ideal, but OK convergence.
			// I don't know if it's still called convergence though if we just zero out the amplitude at a point.
			if (Math.abs(distanceFromEnemy - distance) < 5) {
				impulseSize = 0;
			} else if (Math.abs(distanceFromEnemy - distance) < 20) {
				impulseSize = (impulseSize / super.speed);
			}
			var dirX:int = (enemy.getX() - this.getX());
			var dirY:int = (enemy.getY() - this.getY());
			var forceVec:b2Vec2 = getForceVec(dirX, dirY, impulseSize*2);
			
			var headAngle:Number = movementBody.GetAngle();
			var headDirection:b2Vec2 = new b2Vec2(Math.sin(headAngle) * -1, Math.cos(headAngle));
			var goalDirection:b2Vec2 = new b2Vec2(dirX, dirY);
			var cross:Number = b2Math.CrossVV(headDirection, goalDirection);
//			var angle:Number = Math.abs(Math.atan2(dirY, dirX) - Math.atan2(headDirection.y, headDirection.x));

			var torque:Number = 10;
//			if (angle < 3.1) // A small angle will be between 3 and 3.14159
			if (cross > 0) {
				movementBody.SetAngularVelocity(-1 * torque);
			} else {
				movementBody.SetAngularVelocity(torque);
			}

			this.movementBody.ApplyImpulse(forceVec, this.movementBody.GetPosition());
			
		}
		
		// Returns a vector in the (xDir, yDir) direction with a magnitude of impulseSize * 0.001.
		private function getForceVec(xDir:Number, yDir:Number, impulseSize:Number):b2Vec2 {
			var vec:b2Vec2 = new b2Vec2(xDir, yDir);
			vec.Normalize();
			vec.Multiply(impulseSize * 0.01);
			return vec;
		}
		
		private function attack(attackPoint:FlxPoint):void {
			for each (var adapt:Adaptation in _adaptations) {
				adapt.attack(target);
			}
		}
		
		private function aim(attackPoint:FlxPoint):void {
			for each (var adapt:Adaptation in _adaptations) {
				adapt.aim(target);
			}
		}
		
		private function passiveMovement():void{
						
			if(Math.abs(this.getX()-original.x)<20 && Math.abs(this.getY()-original.y)<20){
				current = new FlxPoint(original.x + boxBound, original.y);
			}
			else if(Math.abs(this.getX()-(original.x + boxBound))<20 && Math.abs(this.getY()-original.y)<20){
				current = new FlxPoint(original.x + boxBound, original.y - boxBound);
			}
			else if(Math.abs(this.getX()-(original.x + boxBound))<20 && Math.abs(this.getY()-(original.y - boxBound))<20){
				current = new FlxPoint(original.x, original.y - boxBound);
			}
			else if(Math.abs(this.getX()-original.x)<20 && Math.abs(this.getY()-(original.y - boxBound))<20){
				current = new FlxPoint(original.x, original.y);
			}
			
			movetoPoint(current, 10);
		}
			
		private function movetoPoint(target:FlxPoint, distance:Number):void {
			var impulseSize:int = super.speed;
			var distanceFromPoint:int = Math.sqrt(Math.pow(this.getX() - target.x, 2) + Math.pow(this.getY() - target.y, 2));
			if (distanceFromPoint < distance)
				impulseSize = -1*super.speed;
			// Non-ideal, but OK convergence.
			// I don't know if it's still called convergence though if we just zero out the amplitude at a point.
			if (Math.abs(distanceFromPoint - distance) < 5) {
				impulseSize = 0;
			} else if (Math.abs(distanceFromPoint - distance) < 20) {
				impulseSize = (impulseSize / super.speed);
			}
			var dirX:int = (target.x - this.getX());
			var dirY:int = (target.y - this.getY());
			var forceVec:b2Vec2 = getForceVec(dirX, dirY, impulseSize);
			
			var headAngle:Number = movementBody.GetAngle();
			var headDirection:b2Vec2 = new b2Vec2(Math.sin(headAngle) * -1, Math.cos(headAngle));
			var goalDirection:b2Vec2 = new b2Vec2(dirX, dirY);
			var cross:Number = b2Math.CrossVV(headDirection, goalDirection);
			
			var torque:Number = 5;
			if (cross > 0) {
				movementBody.SetAngularVelocity(-1 * torque);
			} else {
				movementBody.SetAngularVelocity(torque);
			}
				
			this.movementBody.ApplyImpulse(forceVec, this.movementBody.GetPosition());
		}
	}
}
