package
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	
	public class BubbleGun extends Appendage
	{
		// bubble gun joint locations
		private var bubbleGunJoint:b2Vec2 = new b2Vec2(31,11);
		
		private var jointAngleCorrection:Number = Math.PI/2;
		
		// images
		[Embed(source='res/bubbleSnapper1.png')]
		public static var bubbleGunImg:Class;
		
		public function BubbleGun(jointPos:b2Vec2, jointAngle, owner:Creature)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.BUBBLEGUN, 30, true, 2, jointPos, jointAngle, owner);
			
			var world:b2World = AEWorld.AEB2World;
			
			var bubbleGun:BoxBubbleGun;
			
			var revoluteJointDef:b2RevoluteJointDef;
			
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
		
		override public function attack():void
		{
			super.attack();
			trace("bubble gun attacking");
			// insert code to shoot a bubble here
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}