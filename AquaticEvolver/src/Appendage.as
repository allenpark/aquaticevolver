// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import Creature.AECreature;
	import Creature.AESegment;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Appendage extends Adaptation {
		protected var type:Number;
		
		protected var jointPos:b2Vec2;
		protected var jointAngle:Number;
		protected var segment:B2FlxSprite;
		
		public function Appendage(type:Number, cost:int, isAttack:Boolean, attackDamage:int, jointPos:b2Vec2, jointAngle:Number, creature:AECreature, segment:B2FlxSprite) {
			super(cost, isAttack, attackDamage, creature);
			this.type = type;
			this.jointPos = jointPos;
			// jointAngle is given in radians with 0 defined as being completely vertical and positive clockwise
			this.jointAngle = jointAngle;
			this.segment = segment;
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function color(color:Number):void {
			segment.color = color;
		}
		
		/** takes in a AppendageType int, b2Vec2 in local box2D coordinates that specifies the position of the joint,
		 * angle in radians specifying the orientation of the joint, and a Creature specifying the owner of the appendage
		 */
		public static function createAppendageWithType(type:Number, jointPos:b2Vec2, jointAngle:Number, creature:AECreature, segment:B2FlxSprite): Appendage
		{
			var appendage:Appendage;
			
			switch (type)
			{
				case AdaptationType.SPIKE:
//					FlxG.log("Creating a new spike");
					appendage = new Spike(jointPos, jointAngle, creature, segment);
					break;
				case AdaptationType.TENTACLE:
//					FlxG.log("Creating a new tentacle");
					appendage = new Tentacle(jointPos, jointAngle, creature, segment);
					break;
				case AdaptationType.MANDIBLE:
//					FlxG.log("Creating a new mandible");
					appendage = new Mandible(jointPos, jointAngle, creature, segment);
					break;
				case AdaptationType.BUBBLEGUN:
//					FlxG.log("Creating a new bubble gun");
					appendage = new BubbleGun(jointPos, jointAngle, creature, segment);
					break;
				case AdaptationType.SPIKESHOOTER:
					//					FlxG.log("Creating a new bubble gun");
					appendage = new SpikeShooter(jointPos, jointAngle, creature, segment);
					break;
				case AdaptationType.POISONCANNON:
					//					FlxG.log("Creating a new poison cannon");
					appendage = new PoisonCannon(jointPos, jointAngle, creature, segment);
					break;
				default:
					//					FlxG.log("Creating a new default spike");
					appendage = new Spike(jointPos, jointAngle, creature, segment);
					break;
			}
			AEWorld.world.add(appendage);
			return appendage;
		}
		
		public function convertToBox2D(pixelCoords:b2Vec2):b2Vec2 {
			var x:Number = AEWorld.b2NumFromFlxNum(pixelCoords.x);
			var y:Number = AEWorld.b2NumFromFlxNum(pixelCoords.y);
			var localPos:b2Vec2 = new b2Vec2(x,y);
			return localPos;
		}
		
		public function convertJointPosToFlixel(sprite:B2FlxSprite,jointPos:b2Vec2):b2Vec2 {
			var x:Number = jointPos.x+sprite.getBody().GetPosition().x;
			var y:Number = jointPos.y+sprite.getBody().GetPosition().y;
			
			x = AEWorld.flxXFromB2X(x,sprite.width);
			y = AEWorld.flxYFromB2Y(y,sprite.height);
			var flixelPos:b2Vec2 = new b2Vec2(x,y);
			return flixelPos;
		}
		
		/*override public function kill():void {
		super.kill();
		
		
		}*/
		
		protected function calcB2Impulse(point:FlxPoint, bodyPoint:FlxPoint):b2Vec2 {
			var angle:Number = Math.atan2(point.y - bodyPoint.y,point.x - bodyPoint.x);
			var magnitude:Number = 0.001;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
			/*var vec:b2Vec2 = new b2Vec2(point.x - bodyPoint.x, point.y - bodyPoint.y);
			vec.Normalize();
			vec.Multiply(0.001);
			return vec;*/
		}
	}
}
