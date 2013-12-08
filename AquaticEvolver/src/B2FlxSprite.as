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
		protected var _groupFilter:Number;

		
		public function B2FlxSprite(x:int, y:int,  angle:Number=0,Graphic:Class=null, 
									width:Number=0, height:Number=0,shape:b2PolygonShape=null, groupFilter:Number=undefined):void
		{
			//trace("Constructing b2flxsprite with groupfilter:"+groupFilter);
			_groupFilter = groupFilter;
			super(x,y);
			if (Graphic) {
				this.loadGraphic(Graphic,true,true,width,height);
			}
			var position:b2Vec2 = new b2Vec2(AEWorld.b2NumFromFlxNum(x), AEWorld.b2NumFromFlxNum(y));
			//trace("Shape" + shape);
			body = bodyBuilder(position, angle, shape).build();
		}
		
		override public function update():void
		{
			x = AEWorld.flxXFromB2X(body.GetPosition().x, width);
			y = AEWorld.flxYFromB2Y(body.GetPosition().y, height);
			angle = AEWorld.flxAngleFromB2Angle(body.GetAngle());
			super.update();
		}
		
		protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			if(shape == null){
				//Setting default of spite if none passed in 
				shape = new b2PolygonShape();
				shape.SetAsBox(AEWorld.b2NumFromFlxNum(width)/2.0, AEWorld.b2NumFromFlxNum(height)/2.0);
			}
			var b2bb:B2BodyBuilder = new B2BodyBuilder(position, angle)
				.withShape(shape)
				.withType(b2Body.b2_dynamicBody)
				.withDensity(0.1)
				.withGroupFilter(_groupFilter);
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