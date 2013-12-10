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
	import org.flixel.FlxU;
	
	public class AEPlayer extends AECreature
	{	
		//Swimming sound effects
		[Embed(source='res/sfx/Swim1.mp3')]
		public var Swim1SFX:Class;
		[Embed(source='res/sfx/Swim2.mp3')]
		public var Swim2SFX:Class;
		[Embed(source='res/sfx/Swim3.mp3')]
		public var Swim3SFX:Class;
		[Embed(source='res/sfx/Swim4.mp3')]
		public var Swim4SFX:Class;
		[Embed(source='res/sfx/Swim5.mp3')]
		public var Swim5SFX:Class;
		[Embed(source='res/sfx/Swim6.mp3')]
		public var Swim6SFX:Class;
		[Embed(source='res/sfx/Swim7.mp3')]
		public var Swim7SFX:Class;
		[Embed(source='res/sfx/Swim8.mp3')]
		public var Swim8SFX:Class;
		[Embed(source='res/sfx/Swim9.mp3')]
		public var Swim9SFX:Class;
		public var swimNoises:Array = new Array();
		
		private var defaultMovementScheme:Boolean = true; 
		public var aboveTop: Boolean = false; 
		
		public function AEPlayer(x:Number, y:Number, health:Number)
		{	
			swimNoises[0] = Swim1SFX;
			swimNoises[1] = Swim2SFX;
			swimNoises[2] = Swim3SFX;
			swimNoises[3] = Swim4SFX;
			swimNoises[4] = Swim5SFX;
			swimNoises[5] = Swim6SFX;
			swimNoises[6] = Swim7SFX;
			swimNoises[7] = Swim8SFX;
			swimNoises[8] = Swim9SFX;
			
			//Player has special ID value of 1
			var headDef:AEHeadDef = AECreature.head5Def(x,y);
			var torsoDef:AETorsoDef = AECreature.torso1Def(x,y);
			var tailDef:AETailDef = AECreature.tail1Def(x,y);
			super(x, y, health, headDef, torsoDef, tailDef);

			//attachAppendage(AdaptationType.POISONCANNON);	
			addAdaptation(AdaptationType.SPIKESHOOTER);
			addAdaptation(AdaptationType.SPIKESHOOTER);
			addAdaptation(AdaptationType.BUBBLEGUN);
			//attachAppendage(AdaptationType.SHELL);
			addAdaptation(AdaptationType.TENTACLE);
		}
		
		override public function getID():Number
		{
			return 1;
		}
		
		public function getFollowObject():B2FlxSprite
		{
			return _head.headSegment;
		}
		
		override public function update():void
		{
			//this.x = FlxG.camera.scroll.x + (FlxG.width  / 2.0);
			//this.y = FlxG.camera.scroll.y + (FlxG.height / 2.0);
			super.update();
			if (!FlxG.paused) {
				var movementBody:b2Body = _head.headSegment.getBody();
				var xDir:Number = 0;
				var yDir:Number = 0;
				

				if(FlxG.keys.justPressed("LEFT") || FlxG.keys.justPressed("RIGHT") || FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("DOWN") || 
					FlxG.keys.justPressed("W") || FlxG.keys.justPressed("A") || FlxG.keys.justPressed("S") || FlxG.keys.justPressed("D")){
					var randomSong = FlxU.getRandom(swimNoises,0, 9);
					FlxG.play(randomSong);
				}
				if(FlxG.mouse.justPressed())
					//if(FlxG.mouse.pressed())
				{
					
					var mousePoint:FlxPoint = new FlxPoint(FlxG.camera.scroll.x + FlxG.mouse.screenX, FlxG.camera.scroll.y + FlxG.mouse.screenY);
					var playerPoint:FlxPoint = new FlxPoint(AEWorld.flxNumFromB2Num(movementBody.GetPosition().x), AEWorld.flxNumFromB2Num(movementBody.GetPosition().y));
					movementBody.ApplyImpulse(calcB2Impulse(mousePoint, playerPoint), movementBody.GetPosition());
					attack();
					//trace("attack!");
				}
					
					// moving the player based on the arrow keys inputs
				else if (FlxG.keys.LEFT && FlxG.keys.RIGHT || FlxG.keys.A && FlxG.keys.D) {
				}
				else if (FlxG.keys.LEFT || FlxG.keys.A) {
					//					trace("BoxPlayer: left");
					xDir = -1*this.speed;
				} else if (FlxG.keys.RIGHT || FlxG.keys.D) {
					//					trace("BoxPlayer: right");
					xDir = 1*this.speed;
				}
				
				if (FlxG.keys.UP && FlxG.keys.DOWN || FlxG.keys.W && FlxG.keys.S)	{
				}
				else if (FlxG.keys.UP || FlxG.keys.W) {
					//					trace("BoxPlayer: up");
					yDir = -1*this.speed;
				} else if (FlxG.keys.DOWN || FlxG.keys.S) {
					//					trace("BoxPlayer: down");
					yDir = 1*this.speed;
				}
				if (this.aboveTop){
					yDir = 1*this.speed;
				}
				
				if(defaultMovementScheme) {
					var playerPosition:b2Vec2 = movementBody.GetPosition();
					movementBody.ApplyImpulse(getForceVec(xDir, yDir, .5), movementBody.GetPosition());
					
					var mouseX:Number = FlxG.mouse.x;
					var mouseY:Number = FlxG.mouse.y;
					var playerX:Number = playerPosition.x;
					var playerY:Number = playerPosition.y;
					
					var impulseSize:int = super.speed;
					var dirX:int = (mouseX - this.getX());
					var dirY:int = (mouseY - this.getY());
					
					var headAngle:Number = movementBody.GetAngle();
					var headDirection:b2Vec2 = new b2Vec2(Math.sin(headAngle) * -1, Math.cos(headAngle));
					var goalDirection:b2Vec2 = new b2Vec2(dirX, dirY);
					var cross:Number = b2Math.CrossVV(headDirection, goalDirection);
					var torque:Number = 7.0;
					if (cross > 0) {
						movementBody.SetAngularVelocity(-1 * torque);
					} else {
						movementBody.SetAngularVelocity(torque);
					}
					
				} else {
					var angle:Number = movementBody.GetAngle();
					if (this.aboveTop){
						yDir= -1*this.speed;
						xDir = (Math.PI - angle)*50;
					}
					var force:b2Vec2 = new b2Vec2(0.05 * Math.sin(angle) * yDir * -1, 0.05 * Math.cos(angle) * yDir);
					
					movementBody.ApplyImpulse(force, movementBody.GetPosition());
					movementBody.SetAngularVelocity(torque * xDir);
				}
			}
		}
		private function attack():void
		{
			for each (var adapt:Adaptation in _adaptations)
			{
				/*
				else if (adapt.adaptationType == AdaptationType.SHELL){
					FlxG.play(ShellSFX);
				}*/
				adapt.attack(FlxG.mouse.getScreenPosition());
			}
		}
		
		// Returns a vector in the (xDir, yDir) direction with a magnitude of impulseSize * 0.001.
		private function getForceVec(xDir:Number, yDir:Number, impulseSize:Number):b2Vec2 {
			var vec:b2Vec2 = new b2Vec2(xDir, yDir);
			vec.Normalize();
			vec.Multiply(impulseSize * 0.1);
			return vec;
		}
		public function goAboveTop():void{
			this.aboveTop = true;
		}
		public function goBelowTop(): void{
			this.aboveTop = false 
		}
		
		private function calcB2Impulse(mousePoint:FlxPoint, bodyPoint:FlxPoint):b2Vec2
		{
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = 0.002;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
		}
		
		override public function kill():void
		{
			for each (var adaptation:Adaptation in this._adaptations)
			{
				adaptation.kill();
			}
			this._adaptations = new Array();
			super.kill();
		}
	}
}