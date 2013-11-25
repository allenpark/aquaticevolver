package
{
	
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import org.flixel.FlxSprite;
	
	public class B2FlxSprite extends FlxSprite
	{
		protected var body:b2Body;
		
		public function B2FlxSprite(x:int, y:int,  angle:Number=0, Graphic:Class=null, width:Number=0, height:Number=0):void
		{
			super(x,y);
			if (Graphic) {
				this.loadGraphic(Graphic,true,true,width,height);
			}
			var position:b2Vec2 = new b2Vec2(AEWorld.b2NumFromFlxNum(x), AEWorld.b2NumFromFlxNum(y));
			body = bodyBuilder(position, angle).build();
		}
		
		override public function update():void
		{
			x = AEWorld.flxXFromB2X(body.GetPosition().x, width);
			y = AEWorld.flxYFromB2Y(body.GetPosition().y, height);
			angle = AEWorld.flxAngleFromB2Angle(body.GetAngle());
			super.update();
		}
		
		protected function bodyBuilder(position:b2Vec2, angle:Number):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(width)/2.0, AEWorld.b2NumFromFlxNum(height)/2.0);
			var b2bb:B2BodyBuilder = new B2BodyBuilder(position, angle).withShape(boxShape).withType(b2Body.b2_dynamicBody)
				.withDensity(0.1);
			return b2bb;
		}
		
		override public function kill():void
		{
			AEWorld.AEB2World.DestroyBody(this.body);
			super.kill();
		}
		
		public function getBody():b2Body
		{
			return body;
		}
	}
}