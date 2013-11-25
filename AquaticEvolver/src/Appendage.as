// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Appendage extends Adaptation {
		protected var type:Number;
		
		protected var jointPos:b2Vec2;
		protected var jointAngle:Number;
		
		public function Appendage(type:Number, cost:int, isAttack:Boolean, attackDamage:int, jointPos:b2Vec2, jointAngle:Number, owner:Creature) {
			super(cost, isAttack, attackDamage, owner);
			this.type = type;
			this.jointPos = jointPos;
			// jointAngle is given in radians with 0 defined as being completely vertical and positive clockwise
			this.jointAngle = jointAngle;
		}
		
		override public function update():void {
			super.update();
		}
		
		/* takes in a AppendageType int, b2Vec2 in local box2D coordinates that specifies the position of the joint,
		angle in radians specifying the orientation of the joint, and a Creature specifying the owner of the appendage
		*/
		public static function createAppendageWithType(type:Number, jointPos:b2Vec2, jointAngle:Number, owner:Creature, world:AEWorld=null): Appendage
		{
			var appendage:Appendage;
			
			switch (type)
			{
				case AppendageType.SPIKE:
//					FlxG.log("Creating a new spike");
					appendage = new Spike(jointPos, jointAngle, owner);
					break;
				case AppendageType.TENTACLE:
//					FlxG.log("Creating a new tentacle");
					appendage = new Tentacle(jointPos, jointAngle, owner);
					break;
				case AppendageType.MANDIBLE:
//					FlxG.log("Creating a new mandible");
					appendage = new Mandible(jointPos, jointAngle, owner);
					break;
				case AppendageType.BUBBLEGUN:
//					FlxG.log("Creating a new bubble gun");
					appendage = new BubbleGun(jointPos, jointAngle, owner, world);
					break;
				default:
//					FlxG.log("Creating a new default spike");
					appendage = new Spike(jointPos, jointAngle, owner);
					break;
			}
			
			return appendage;
		}
		
		public function convertToBox2D(pixelCoords:b2Vec2):b2Vec2 {
			var x:Number = AEWorld.b2NumFromFlxNum(pixelCoords.x);
			var y:Number = AEWorld.b2NumFromFlxNum(pixelCoords.y);
			var localPos:b2Vec2 = new b2Vec2(x,y);
			return localPos;
		}
		
		/*override public function kill():void {
			super.kill();
			
			
		}*/
		
		protected function calcB2Impulse(mousePoint:FlxPoint, bodyPoint:FlxPoint):b2Vec2 {
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = 0.001;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
		}
	}
}
