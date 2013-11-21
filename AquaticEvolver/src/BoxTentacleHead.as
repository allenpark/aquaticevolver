package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	
	public class BoxTentacleHead extends B2FlxSprite
	{
		private var bodyWidth:int = 20/2;
		private var bodyHeight:int = 44/2;
		public var owner:Creature;
		public var adaptOwner:Adaptation;
		
		public function BoxTentacleHead(x:Number, y:Number, owner:Creature, adaptOwner:Adaptation, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			this.owner = owner;
			this.adaptOwner = adaptOwner;
			super(x, y, Graphic, width, height);
		}
		
		override protected function bodyBuilder():B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = new B2BodyBuilder().withShape(boxShape).withType(b2Body.b2_dynamicBody)
				.withDensity(0.01).withLinearDamping(2)
				.withData(new CollisionData(this.owner, SpriteType.TENTACLEHEAD, this.adaptOwner));
			return b2bb;
		}
	}
}

