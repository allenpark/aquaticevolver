package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	
	public class Tentacle extends Appendage
	{
		private var tentacleMidSegments:int = 1;
		private var tentacleHead:BoxTentacleHead;
		
		// tentacle joint locations
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(0,-15);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(0,15);
		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(0,19);
		private var midSegments:Array = new Array();
		
		private var jointAngleCorrection:Number = Math.PI;
		
		// images
		[Embed(source='res/tentacleHead1.png')]
		public static var tentacleHeadImg:Class;
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Tentacle(jointPos:b2Vec2, jointAngle:Number, owner:Creature)
		{
			jointAngle = jointAngle + jointAngleCorrection;
			super(AppendageType.TENTACLE, 50, true, 2, jointPos, jointAngle, owner);
			
			var world:b2World = AEWorld.AEB2World;
			
			var prevSprite:B2FlxSprite = owner;
			var sprite:B2FlxSprite;
			
			var revoluteJointDef:b2RevoluteJointDef;
			for (var i:int = 0; i < tentacleMidSegments; i++) {
				
				// create the sprite
				trace(owner);
				sprite = new BoxTentacleMid(0, 0, owner, this, tentacleMidImg, 32, 64);
				midSegments.push(sprite);
				this.add(sprite);
				
				// create the jointDef
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = prevSprite.getBody();
				revoluteJointDef.bodyB = sprite.getBody();
				if (i == 0) {
					revoluteJointDef.localAnchorA = jointPos;
					revoluteJointDef.referenceAngle = jointAngle;
				} else {
					revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
					revoluteJointDef.referenceAngle = 0;
				}
				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(tentacleSegmentStartJoint);
				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.enableLimit = true;
				revoluteJointDef.lowerAngle = -Math.PI/4;
				revoluteJointDef.upperAngle = Math.PI/4;
				revoluteJointDef.collideConnected = false;
				world.CreateJoint(revoluteJointDef);
				
				prevSprite = sprite;
			}
			
			// create the sprite
			tentacleHead = new BoxTentacleHead(0, 0, owner, this, tentacleHeadImg, 32, 64);
			this.add(tentacleHead);
			
			// create the jointDef
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = prevSprite.getBody();
			revoluteJointDef.bodyB = sprite.getBody();
			revoluteJointDef.bodyA = prevSprite.getBody();
			revoluteJointDef.bodyB = tentacleHead.getBody();
			if (tentacleMidSegments == 0)
			{
				revoluteJointDef.localAnchorA = new b2Vec2(jointPos.x,jointPos.y);
			}else
			{
				revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
			}
			FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
			revoluteJointDef.localAnchorB = convertToBox2D(tentacleHeadJoint);
			FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
			revoluteJointDef.referenceAngle = Math.PI;
			revoluteJointDef.enableLimit = true;
			revoluteJointDef.lowerAngle = -Math.PI/4;
			revoluteJointDef.upperAngle = Math.PI/4;
			revoluteJointDef.collideConnected = false;
			
			// add joint to world
			world.CreateJoint(revoluteJointDef);
		}
		
		override public function attack(point:FlxPoint):void
		{
			super.attack(point);
			//trace("tentacle attacking");
			var mousePoint:FlxPoint = FlxG.mouse.getScreenPosition();
			var headPoint:FlxPoint = tentacleHead.getScreenXY();
			var tentacleBody:b2Body = tentacleHead.getBody();
			tentacleBody.ApplyImpulse(calcB2Impulse(point, headPoint), tentacleBody.GetPosition());
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}