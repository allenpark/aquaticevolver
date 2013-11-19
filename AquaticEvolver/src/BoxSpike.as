package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import B2Builder.B2BodyBuilder;
	
	public class BoxSpike extends B2FlxSprite
	{
		private var bodyWidth:int = 20/2;
		private var bodyHeight:int = 88/2;
		public var owner:Creature;
		
		public function BoxSpike(x, y, owner:Creature, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			this.owner = owner;
			super(x, y, Graphic, width, height);			
		}
		
		override protected function bodyBuilder():B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = new B2BodyBuilder().withShape(boxShape).withType(b2Body.b2_dynamicBody)
				.withDensity(0.01).withLinearDamping(2).withData(new CollisionData(this.owner, SpriteType.SPIKE));
			return b2bb;
		}
	}
}
