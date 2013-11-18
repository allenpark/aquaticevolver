package B2Builder
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	public class B2RevoluteJointBuilder extends B2JointBuilder
	{
		private var _enableLimit:Boolean;
		private var _lowerAngle:Number = Math.PI/4.0;
		private var _upperAngle:Number = Math.PI/4.0;
		
		public function B2RevoluteJointBuilder(bodyA:b2Body, bodyB:b2Body, localAnchorA:b2Vec2, localAnchorB:b2Vec2)
		{
			super(bodyA, bodyB, localAnchorA, localAnchorB);
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