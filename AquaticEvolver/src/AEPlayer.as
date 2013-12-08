package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;
	
	import Def.AEHeadDef;
	import Def.AETailDef;
	import Def.AETorsoDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class AEPlayer extends AECreature
	{
		private var defaultMovementScheme:Boolean = false; 
		public var aboveTop: Boolean = false; 
		
		public function AEPlayer(x:Number, y:Number, health:Number)
		{	

			//Player has special ID value of 1
			trace("id has been set to:"+_id);
			var headDef:AEHeadDef = AECreature.head1Def(x,y);
			var torsoDef:AETorsoDef = AECreature.torso1Def(x,y);
			var tailDef:AETailDef = AECreature.tail1Def(x,y);
			super(SpriteType.PLAYER, x, y, health, headDef, torsoDef, tailDef);
			attachAppendage(AppendageType.TENTACLE);
//			attachAppendage(AppendageType.SPIKESHOOTER);
//			attachAppendage(AppendageType.SPIKE);
//			attachAppendage(AppendageType.BUBBLEGUN);
			attachAppendage(AppendageType.MANDIBLE);	
//			attachAppendage(AppendageType.SPIKE);
//			attachAppendage(AppendageType.TENTACLE);
//			attachAppendage(AppendageType.SPIKE);
//			attachAppendage(AppendageType.TENTACLE);
//			attachAppendage(AppendageType.SPIKE);		
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
			this.x = FlxG.camera.scroll.x + (FlxG.width  / 2.0);
			this.y = FlxG.camera.scroll.y + (FlxG.height / 2.0);
			super.update();
			if (!FlxG.paused) {
				var movementBody:b2Body = _head.headSegment.getBody();
				var xDir:Number = 0;
				var yDir:Number = 0;
				
				if(FlxG.mouse.justPressed())
				//if(FlxG.mouse.pressed())
				{
					
					var mousePoint:FlxPoint = new FlxPoint(FlxG.camera.scroll.x + FlxG.mouse.screenX, FlxG.camera.scroll.y + FlxG.mouse.screenY);
					var playerPoint:FlxPoint = new FlxPoint(AEWorld.flxNumFromB2Num(movementBody.GetPosition().x), AEWorld.flxNumFromB2Num(movementBody.GetPosition().y));
					movementBody.ApplyImpulse(calcB2Impulse(mousePoint, playerPoint), movementBody.GetPosition());
					attack();
					trace("attack!");
				}
					
					// moving the player based on the arrow keys inputs
				else if (FlxG.keys.LEFT && FlxG.keys.RIGHT) {
				} 
				else if (FlxG.keys.LEFT) {
					//					trace("BoxPlayer: left");
					xDir = -1*this.speed;
				} else if (FlxG.keys.RIGHT) {
					//					trace("BoxPlayer: right");
					xDir = 1*this.speed;
				}
					
				if (FlxG.keys.UP && FlxG.keys.DOWN)	{
				}
				else if (FlxG.keys.UP) {
					//					trace("BoxPlayer: up");
					yDir = -1*this.speed;
				} else if (FlxG.keys.DOWN) {
					//					trace("BoxPlayer: down");
					yDir = 1*this.speed;
				}
				if (this.aboveTop){
					yDir = 1*this.speed;
				}
				
				if(defaultMovementScheme) {
					movementBody.ApplyImpulse(getForceVec(xDir, yDir), movementBody.GetPosition());					
				} else {
					var angle:Number = movementBody.GetAngle() + Math.PI/2;
					if (this.aboveTop){
						yDir= -1*this.speed;
						xDir = (Math.PI - angle)*50;
					}
					var force:b2Vec2 = new b2Vec2(0.05 * Math.sin(angle) * yDir * -1, 0.05 * Math.cos(angle) * yDir);

					movementBody.ApplyImpulse(force, movementBody.GetPosition());
					var torque:Number = 0.5;
					movementBody.SetAngularVelocity(torque * xDir);
				}
			}
		}
		private function attack():void
		{
			for each (var adapt:Adaptation in _adaptations)
			{
				adapt.attack(FlxG.mouse.getScreenPosition());
			}
		}
		
		private function getForceVec(xDir:Number, yDir:Number):b2Vec2 {
			var vec:b2Vec2;
			if ( xDir != 0 && yDir != 0) {
				vec = new b2Vec2(xDir * 1/Math.sqrt(2), yDir * 1/Math.sqrt(2));
			} else {
				vec = new b2Vec2(xDir, yDir);
			}
			vec.Multiply(0.05);
			return vec;
		}
		public function goAboveTop():void{
			this.aboveTop = true;
		}
		public function goBelowTop (): void{
			this.aboveTop = false 
		}
		
		private function calcB2Impulse(mousePoint:FlxPoint, bodyPoint:FlxPoint):b2Vec2
		{
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = 0.002;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
		}
	}
}