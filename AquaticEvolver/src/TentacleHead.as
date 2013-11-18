package
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import B2Builder.B2BodyBuilder;
	
	public class TentacleHead extends B2FlxSprite
	{
		private var bodyWidth:int = 10;
		private var bodyHeight:int = 22;
		
		public function TentacleHead(x, y, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			super(x, y, Graphic, width, height);			
		}
		
		override protected function bodyBuilder():B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = new B2BodyBuilder().withShape(boxShape).withType(b2Body.b2_dynamicBody)
				.withDensity(0.01).withLinearDamping(2);
			return b2bb;
		}
	}
}

