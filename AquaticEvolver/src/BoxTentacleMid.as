package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	public class BoxTentacleMid extends B2FlxSprite
	{
		private var bodyWidth:int = 24/2;
		private var bodyHeight:int = 40/2;
		public var owner:*;
		public var adaptOwner:Adaptation;
		
		public function BoxTentacleMid(x:Number, y:Number, owner:*, adaptOwner:Adaptation, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			this.owner = owner;
			this.adaptOwner = adaptOwner;
			super(x, y, 0, Graphic, width, height);
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = new B2BodyBuilder(position, angle).withShape(boxShape).withType(b2Body.b2_dynamicBody)
				.withDensity(0.01).withLinearDamping(2)
				.withData(new CollisionData(this.owner, SpriteType.TENTACLEMID, this.adaptOwner));
			return b2bb;
		}
	}
}