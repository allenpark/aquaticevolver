// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	public class Appendage extends Adaptation {
		
		protected var jointPos:b2Vec2;
		protected var jointAngle:Number;
		
		public function Appendage(name:String, cost:int, isAttack:Boolean, attackDamage:int, jointPos:b2Vec2, jointAngle:Number, owner:Creature) {
			super(name, cost, isAttack, attackDamage, owner);
			this.jointPos = jointPos;
			// jointAngle is given in radians with 0 defined as being completely vertical and positive clockwise
			this.jointAngle = jointAngle;
		}
		
		override public function update():void {
			super.update();
		}
		
		public function convertToBox2D(pixelCoords:b2Vec2):b2Vec2 {
			var x:Number = AEWorld.b2NumFromFlxNum(pixelCoords.x);
			var y:Number = AEWorld.b2NumFromFlxNum(pixelCoords.y);
			var localPos:b2Vec2 = new b2Vec2(x,y);
			return localPos;
		}
	}
}
