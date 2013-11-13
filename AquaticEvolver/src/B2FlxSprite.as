package
{
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	
	import org.flixel.FlxSprite;
	
	public class B2FlxSprite extends FlxSprite
	{
		protected var _obj:b2Body;
		
		public function B2FlxSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			_obj = bodyBuilder().build();
		}
		
		override public function update():void
		{
			x = AEWorld.flxXFromB2X(_obj.GetPosition().x, width);
			y = AEWorld.flxYFromB2Y(_obj.GetPosition().y, height);
			angle = AEWorld.flxAngleFromB2Angle(_obj.GetAngle());
			super.update();
		}
		
		protected function bodyBuilder():B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(width)/2.0, AEWorld.b2NumFromFlxNum(height)/2.0);
			var b2bb:B2BodyBuilder = new B2BodyBuilder().withShape(boxShape).withType(b2Body.b2_dynamicBody);
			return b2bb;
		}
		
		override public function kill():void
		{
			AEWorld.AEB2World.DestroyBody(this._obj);
			super.kill();
		}
	}
}