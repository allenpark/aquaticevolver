package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	
	public class BubbleGun extends Appendage
	{
		// bubble gun joint locations
		private var bubbleGunJoint:b2Vec2 = new b2Vec2(31,11);
		
		private var bubbleGun:BoxBubbleGun;
		
		private var jointAngleCorrection:Number = Math.PI/2;
		
		private var worldInst:AEWorld;
		// images
		[Embed(source='res/bubbleSnapper1.png')]
		public static var bubbleGunImg:Class;
		
		public function BubbleGun(jointPos:b2Vec2, jointAngle, owner:Creature, worldInst:AEWorld)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.BUBBLEGUN, 30, true, 2, jointPos, jointAngle, owner);
			
			var world:b2World = AEWorld.AEB2World;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
			this.worldInst = worldInst;
			
			// create the sprites
			trace(owner);
			bubbleGun = new BoxBubbleGun(0, 0, owner, this, bubbleGunImg, 128, 128);
			this.add(bubbleGun);
			
			// create the joint from base to creature
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = owner.getBody();
			revoluteJointDef.bodyB = bubbleGun.getBody();
			revoluteJointDef.localAnchorA = jointPos;
			FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(bubbleGunJoint);
			FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = jointAngle;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -3*Math.PI/4;
			revoluteJointDef.upperAngle = 3*Math.PI/4;
			revoluteJointDef.collideConnected = false;
			world.CreateJoint(revoluteJointDef);			
		}
		
		override public function attack(point:FlxPoint):void
		{
			super.attack(point);
			trace("bubble gun attacking");
			// insert code to shoot a bubble here

			var headPoint:b2Vec2 = bubbleGun.getBody().GetPosition();
			var bubble:AttackBubble = new AttackBubble(headPoint, this.owner, this, 64, 64, 5, point);
			this.worldInst.add(bubble);
			var bubbleBody:b2Body = bubble.getBody();
			bubbleBody.SetLinearVelocity(calcBulletVelocity(point, bubbleGun.getScreenXY()));//calcB2Impulse(point, bubbleGun.getScreenXY()));
		}
		
		protected function calcBulletVelocity(mousePoint:FlxPoint, bodyPoint:FlxPoint):b2Vec2 {
			var angle:Number = Math.atan2(mousePoint.y - bodyPoint.y,mousePoint.x - bodyPoint.x);
			var magnitude:Number = 3;
			return new b2Vec2(magnitude * Math.cos(angle), magnitude * Math.sin(angle));
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}