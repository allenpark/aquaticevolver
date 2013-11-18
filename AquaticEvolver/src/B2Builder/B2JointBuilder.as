package B2Builder
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	public class B2JointBuilder
	{
		protected var _bodyA:b2Body;
		protected var _bodyB:b2Body;
		protected var _localAnchorA:b2Vec2;
		protected var _localAnchorB:b2Vec2;
		protected var _referenceAngle:Number;
		
		public function B2JointBuilder(bodyA:b2Body, bodyB:b2Body, localAnchorA:b2Vec2, localAnchorB:b2Vec2) {
			_bodyA = bodyA;
			_bodyB = bodyB;
			_localAnchorA = localAnchorA;
			_localAnchorB = localAnchorB;
			_referenceAngle = 0;
		};
		
		public function withBodyA(bodyA:b2Body):B2JointBuilder{
			_bodyA = bodyA;
			return this;
		}
		
		public function withBodyB(bodyB:b2Body):B2JointBuilder{
			_bodyB = bodyB;
			return this;
		}
		
		public function withLocalAnchorA(localAnchorA:b2Vec2):B2JointBuilder{
			_localAnchorA = localAnchorA;
			return this;
		}
		
		public function withLocalAnchorB(localAnchorB:b2Vec2):B2JointBuilder{
			_localAnchorB = localAnchorB;
			return this;
		}
		
		public function withReferenceAngle(referenceAngle:Number):B2JointBuilder{
			_referenceAngle = referenceAngle;
			return this;
		}
		
		public function withRelativeReferenceAngle():B2JointBuilder{
			_referenceAngle = _bodyB.GetAngle() - _bodyA.GetAngle();
			return this;
		}
	}
}