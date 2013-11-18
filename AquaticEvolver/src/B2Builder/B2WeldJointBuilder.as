package B2Builder
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2WeldJoint;
	import Box2D.Dynamics.Joints.b2WeldJointDef;

	public class B2WeldJointBuilder extends B2JointBuilder
	{
		public function B2WeldJointBuilder(bodyA:b2Body, bodyB:b2Body, localAnchorA:b2Vec2, localAnchorB:b2Vec2)
		{
			super(bodyA, bodyB, localAnchorA, localAnchorB);
		}
		
		public function build():b2WeldJoint
		{
			var weldJoint:b2WeldJointDef = new  b2WeldJointDef();
			weldJoint.bodyA = _bodyA;
			weldJoint.localAnchorA = _localAnchorA;
			weldJoint.bodyB = _bodyB;
			weldJoint.localAnchorB = _localAnchorB;
			weldJoint.referenceAngle = _referenceAngle;
			
			return b2WeldJoint (AEWorld.AEB2World.CreateJoint(weldJoint));
		}
	}
}