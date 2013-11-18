package B2Builder
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	public class B2RevoluteJointBuilder
	{
		private var _bodyA:b2Body;
		private var _bodyB:b2Body;
		private var _localAnchorA:b2Vec2;
		private var _localAnchorB:b2Vec2;
		private var _referenceAngle:Number = 0;
		private var _enableLimit:Boolean = false;
		private var _lowerAngle:Number = -Math.PI/4;
		private var _upperAngle:Number = Math.PI/4;
		
		public function B2RevoluteJointBuilder()
		{
		}
		
		public function withBodyA(bodyA:b2Body):B2RevoluteJointBuilder{
			_bodyA = bodyA;
			return this;
		}
		
		public function withBodyB(bodyB:b2Body):B2RevoluteJointBuilder{
			_bodyB = bodyB;
			return this;
		}
		
		public function withLocalAnchorA(localAnchorA:b2Vec2):B2RevoluteJointBuilder{
			_localAnchorA = localAnchorA;
			return this;
		}
		
		public function withLocalAnchorB(localAnchorB:b2Vec2):B2RevoluteJointBuilder{
			_localAnchorB = localAnchorB;
			return this;
		}
		
		public function withReferenceAngle(referenceAngle:Number):B2RevoluteJointBuilder{
			_referenceAngle = referenceAngle;
			return this;
		}
		
		public function withEnabledLimit():B2RevoluteJointBuilder{
			_enableLimit = true;
			return this;
		}
		
		public function withLowerAngle(lowerAngle:Number):B2RevoluteJointBuilder{
			_lowerAngle = lowerAngle;
			return this;
		}
		
		public function withUpperAngle(upperAngle:Number):B2RevoluteJointBuilder{
			_upperAngle = upperAngle;
			return this;
		}
		
		/**
		 * @param swivelAngle The total angle (in radians) that the joint is allowed to rotate
		 */
		public function withSwivelAngle(swivelAngle:Number):B2RevoluteJointBuilder{
			_lowerAngle = -swivelAngle/2.0;
			_upperAngle = swivelAngle/2.0;
			return this;
		}
		
		public function build():b2RevoluteJoint
		{
			var revoluteJoint:b2RevoluteJointDef = new  b2RevoluteJointDef();
			revoluteJoint.bodyA = _bodyA;
			revoluteJoint.localAnchorA = _localAnchorA;
			revoluteJoint.bodyB = _bodyB;
			revoluteJoint.localAnchorB = _localAnchorB;
			revoluteJoint.referenceAngle = _referenceAngle;
			revoluteJoint.enableLimit = _enableLimit;
			if (revoluteJoint.enableLimit){
				revoluteJoint.lowerAngle = _lowerAngle;
				revoluteJoint.upperAngle = _upperAngle;
			}
			return b2RevoluteJoint (AEWorld.AEB2World.CreateJoint(revoluteJoint));
		}
	}
}