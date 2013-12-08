package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxPoint;
	
	public class PoisonCannon extends Appendage
	{
		// bubble gun joint locations
		private var bubbleGunJoint:b2Vec2 = new b2Vec2(0,32);
		
		private var bubbleGun:BoxBubbleGun;
		
		private var jointAngleCorrection:Number = 0;
		
		// images
		
		[Embed(source='res/PoisonCannon1.png')]
		public static var bubbleGunImg:Class;
		
		public function PoisonCannon(jointPos:b2Vec2, jointAngle:Number, owner:*, segment:B2FlxSprite)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AdaptationType.POISONCANNON, 30, true, 2, jointPos, jointAngle, owner, segment);
			
			var world:b2World = AEWorld.AEB2World;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			
			// create the sprites
			trace(owner);
			bubbleGun = new BoxBubbleGun(0, 0, owner, this, bubbleGunImg, 128, 128);
			this.add(bubbleGun);
			
			// create the joint from base to creature
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = segment.getBody();
			revoluteJointDef.bodyB = bubbleGun.getBody();
			revoluteJointDef.localAnchorA = jointPos;
			//			FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(bubbleGunJoint);
			//			FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = jointAngle;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/4;
			revoluteJointDef.upperAngle = Math.PI/4;
			revoluteJointDef.collideConnected = false;
			world.CreateJoint(revoluteJointDef);			
		}
		
		override public function attack(point:FlxPoint):void
		{
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}