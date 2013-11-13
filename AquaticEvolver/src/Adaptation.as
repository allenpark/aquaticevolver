// ActionScript file
package {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	
	// TODO: Fill in this class or reduce it to just a string.
	public class Adaptation extends FlxGroup {
		
		[Embed(source='res/Spike1.png')]
		public static var spikeImg:Class;
		[Embed(source='res/tentacleHead1.png')]
		public static var tentacleHeadImg:Class;
		[Embed(source='res/tentacleBit1.png')]
		public static var tentacleMidImg:Class;
		[Embed(source='res/mandibleBase1.png')]
		public static var mandibleBaseImg:Class;
		[Embed(source='res/mandibleJawPiece1.png')]
		public static var mandibleTopJawImg:Class;
		//		[Embed(source='res/mandibleOtherJawPiece1.png')]
		//		public static var mandibleBottomJawImg:Class;
		
		public var name:String;
		public var attackPower:int;
		public var isAttack:Boolean;
		public var attackDamage:int;
		public var angle:Number;
		
		public var cost:int;
		
		private var sprite:B2FlxSprite;
		private var prevSprite:B2FlxSprite;
		
		// constants
		private var tentacleSegments:int = 5;
		
		// tentacle joint locations
		private var tentacleSegmentStartJoint:b2Vec2 = new b2Vec2(16,20);
		private var tentacleSegmentEndJoint:b2Vec2 = new b2Vec2(16,44);
		private var tentacleHeadJoint:b2Vec2 = new b2Vec2(16,13);
		//		private var tentacleLength:int = 25;
		//		private var tentacleHeadLength:int = 33;
		
		// mandible joint locations
		private var mandibleBaseTopJoint:b2Vec2 = new b2Vec2(24,26);
		private var mandibleBaseBottomJoint:b2Vec2 = new b2Vec2(40,38);
		//		private var mandibleTopJawJoint:b2Vec2 = new b2Vec2(40,38);
		//		private var mandibleBottomJawJoint:b2Vec2 = new b2Vec2(40,38);
		
		private var jointDef:b2RevoluteJointDef;
		
		public function Adaptation(name:String, inputWorld:AEWorld, x:int, y:int, angle:Number) {
			super();
			this.name = name;
			this.angle = angle;
			var world:b2World = AEWorld.AEB2World;
			
			switch (name) {
				case "spike":
					sprite = new B2FlxSprite(0,0);
					sprite.loadGraphic(spikeImg, true, true, 32, 128);
					sprite.angle = angle;
					this.add(sprite);
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 20;
					
					//create the joint
					var weldJointDef:b2WeldJointDef = new b2WeldJointDef();
					weldJointDef.bodyA = inputWorld.player.get_obj();
					weldJointDef.bodyB = sprite.get_obj();
					weldJointDef.localAnchorA = inputWorld.player.get_obj().GetWorldCenter();
					weldJointDef.localAnchorB = sprite.get_obj().GetWorldCenter();
					weldJointDef.collideConnected = false;
					world.CreateJoint(weldJointDef);
					
					break;
				case "tentacle":
					var spriteX:Number = x;
					var spriteY:Number = y;
					var incX:Number = Math.cos(angle)*(tentacleSegmentEndJoint.y - tentacleSegmentStartJoint.y);
					var incY:Number = -Math.sin(angle)*(tentacleSegmentEndJoint.y - tentacleSegmentStartJoint.y);
					
					prevSprite = inputWorld.player;
					for (var i:int = 0; i < tentacleSegments-1; i++) {
						//						sprite = new B2FlxSprite(spriteX,spriteY);
						sprite = new B2FlxSprite(0,0);
						sprite.loadGraphic(tentacleMidImg, true, true, 32, 64);
						sprite.angle = angle+90;
						this.add(sprite);
						spriteX += incX;
						spriteY += incY;
						
						//						create the joint
						jointDef = new b2RevoluteJointDef();
						jointDef.bodyA = prevSprite.get_obj();
						jointDef.bodyB = sprite.get_obj();
						jointDef.localAnchorA = prevSprite.get_obj().GetWorldCenter();
						jointDef.localAnchorB = sprite.get_obj().GetWorldCenter();
						jointDef.collideConnected = false;
						world.CreateJoint(jointDef);
						
						this.prevSprite = sprite;
					}
					spriteX -= incX;
					spriteY -= incY;
					spriteX += Math.cos(angle)*(64-tentacleSegmentEndJoint.y + tentacleHeadJoint.y);
					spriteY += -Math.sin(angle)*(64-tentacleSegmentEndJoint.y + tentacleHeadJoint.y);
					sprite = new B2FlxSprite(0,0);
					sprite.loadGraphic(tentacleHeadImg, true, true, 32, 64);
					sprite.angle = angle+90;
					this.add(sprite);
					
					//						create the joint
					jointDef = new b2RevoluteJointDef();
					jointDef.bodyA = prevSprite.get_obj();
					jointDef.bodyB = sprite.get_obj();
					jointDef.localAnchorA = prevSprite.get_obj().GetWorldCenter();
					jointDef.localAnchorB = sprite.get_obj().GetWorldCenter();
					jointDef.collideConnected = false;
					world.CreateJoint(jointDef);
					
					
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 50;
					break;
				case "mandible":
					//					sprite.loadGraphic(mandibleBaseImg, true, true, 64, 64);
					
					
					//					sprite.loadGraphic(mandibleJawImg, true, true, 128, 64);
					
					this.isAttack = true;
					this.attackDamage = 1;
					this.cost = 30;
					
					//					this.maxVelocity.x = 160;
					//					this.maxVelocity.y = 160;
					//					this.drag.x = this.maxVelocity.x * 2;
					//					this.drag.y = this.maxVelocity.y * 2;
					break;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			// special update code goes in here
			switch (name) {
				case "spike":
					break;
				case "tentacle":
					break;
			}
		}
	}
}
