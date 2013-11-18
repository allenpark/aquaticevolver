package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxG;
	
	public class Tentacle extends Appendage
	{
		private var tentacleMidSegments:int = 5;
		
		// tentacle joint locations
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(0,-15);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(0,15);
		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(0,19);
		//		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(0,20);
		//		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(0,44);
		//		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(0,20);
		
		// images
		[Embed(source='res/tentacleHead1.png')]
		public static var tentacleHeadImg:Class;
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		
		// jointPos is given from the local box2D coordinate system of the player and is the location of the attached point for the adatation
		public function Tentacle(jointPos:b2Vec2, owner:Creature)
		{
			super("tentacle", 50, true, 2, jointPos, owner);
			
			var world:b2World = AEWorld.AEB2World;
			
			var prevSprite:B2FlxSprite = AEWorld.player;
			var sprite:B2FlxSprite;
			
			var revoluteJointDef:b2RevoluteJointDef;
			for (var i:int = 0; i < tentacleMidSegments; i++) {
				
				// create the sprite
				trace(owner);
				sprite = new BoxTentacleMid(0,0,owner,tentacleMidImg,32,64);
				this.add(sprite);
				
				// create the jointDef
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.bodyA = prevSprite.get_obj();
				revoluteJointDef.bodyB = sprite.get_obj();
				if (i == 0){
					revoluteJointDef.localAnchorA = new b2Vec2(jointPos.x,jointPos.y);
				}else
				{
					revoluteJointDef.localAnchorA = convertToBox2D(tentacleSegmentEndJoint);
				}
				FlxG.log("AanchorCoords = " + revoluteJointDef.localAnchorA.x + ", " + revoluteJointDef.localAnchorA.y);
				revoluteJointDef.localAnchorB = convertToBox2D(tentacleSegmentStartJoint);
				FlxG.log("BanchorCoords = " + revoluteJointDef.localAnchorB.x + ", " + revoluteJointDef.localAnchorB.y);
				revoluteJointDef.referenceAngle = 0;
				revoluteJointDef.enableLimit = true;
				revoluteJointDef.lowerAngle = -Math.PI/4;
				revoluteJointDef.upperAngle = Math.PI/4;
				revoluteJointDef.collideConnected = false;
				world.CreateJoint(revoluteJointDef);
				
				prevSprite = sprite;
			}
			
			// create the sprite
			sprite = new BoxTentacleHead(0,0,owner,tentacleHeadImg,32,64);
			this.add(sprite);
			
			// create the jointDef
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.bodyA = prevSprite.get_obj();
			revoluteJointDef.bodyB = sprite.get_obj();
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
		
		override public function update():void
		{
			super.update();
		}
	}
}