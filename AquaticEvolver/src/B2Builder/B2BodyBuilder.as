package B2Builder
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	public class B2BodyBuilder
	{
		private var _friction:Number;
		private var _restitution:Number;
		private var _density:Number;
		private var _shape:b2PolygonShape;	
		
		private var _position:b2Vec2;
		private var _angle:Number;
		private var _type:uint;
		
		private var _linearDamping:Number;
		private var _angularDamping:Number;
		
		private var _data:*;
		
		public function B2BodyBuilder()
		{
			//Defaults
			_friction = 0.0;
			_restitution = 0.5;
			_density = 1.0;
			
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(1.0, 1.0);
			_shape = boxShape;
			
			_position = new b2Vec2(AEWorld.b2NumFromFlxNum(AEWorld.ScreenWidth)/2.0, AEWorld.b2NumFromFlxNum(AEWorld.ScreenHeight/2.0));
			_angle = 0;
			_type = b2Body.b2_dynamicBody;
			
			_linearDamping = 0.0;
			_angularDamping = 0.0;			
		}
		
		public function withFriction(b2Friction:Number):B2BodyBuilder
		{
			_friction = b2Friction;
			return this;
		}
		
		public function withRestitution(b2Restitution:Number):B2BodyBuilder
		{
			_restitution = b2Restitution;
			return this;
		}
		
		public function withDensity(b2Density:Number):B2BodyBuilder
		{
			_density = b2Density;
			return this;
		}
		
		public function withShape(b2Shape:b2PolygonShape):B2BodyBuilder
		{
			_shape = b2Shape;
			return this;
		}
		
		public function withPosition(b2Position:b2Vec2):B2BodyBuilder
		{
			_position = b2Position;
			return this;
		}
		
		public function withAngle(b2Angle:Number):B2BodyBuilder
		{
			_angle = b2Angle;
			return this;
		}
		
		public function withType(b2Type:uint):B2BodyBuilder
		{
			_type = b2Type;
			return this;
		}
		
		public function withLinearDamping(b2LinearDamping:Number):B2BodyBuilder
		{
			_linearDamping = b2LinearDamping;
			return this;
		}
		
		public function withAngularDamping(b2AngularDamping:Number):B2BodyBuilder
		{
			_angularDamping = b2AngularDamping;
			return this;
		}
		
		public function withData(data:CollisionData):B2BodyBuilder
		{
			_data = data;
			return this;
		}
		
		public function build():b2Body
		{
			var fixDef:b2FixtureDef = new b2FixtureDef();
		
			fixDef.density = _density;
			fixDef.restitution = _restitution;
			fixDef.friction = _friction;                        
			fixDef.shape = _shape;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(_position.x, _position.y);
			bodyDef.angle = _angle * (Math.PI / 180);
			bodyDef.type = _type;
			bodyDef.linearDamping = _linearDamping;
			bodyDef.angularDamping = _angularDamping;
			bodyDef.userData = _data;
			
			var body:b2Body = AEWorld.AEB2World.CreateBody(bodyDef);
			body.CreateFixture(fixDef);
			return body;
		}
	}
}