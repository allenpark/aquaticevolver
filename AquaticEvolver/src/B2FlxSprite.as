package
{
	import flash.utils.flash_proxy;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class B2FlxSprite extends FlxSprite
	{
		////////////////////////      box2d traits      ///////////////////////////
		
		protected var _fixDef:b2FixtureDef;
		protected var _bodyDef:b2BodyDef
		protected var _obj:b2Body;
		
		//Physics params default value -> should be part of creature
		protected var _friction:Number = 0.8;
		protected var _restitution:Number = 0.3;
		protected var _density:Number = 0.7;
		
		//Default angle
		protected var _angle:Number = 0;
		//Default body type -> should be part of creature
		protected var _type:uint = b2Body.b2_dynamicBody;
		
		public function B2FlxSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			createBody(); //TODO: should this be getting called here if 
		}
		
		override public function update():void
		{
			x = AEWorld.flxXFromB2X(_obj.GetPosition().x, width);
			y = AEWorld.flxYFromB2Y(_obj.GetPosition().y, height);
			angle = AEWorld.flxAngleFromB2Angle(_obj.GetAngle());
			super.update();
		}
		
		protected function createBody():void
		{     
			_fixDef = new b2FixtureDef();
			
			//TODO: make shape overridable
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(width)/2.0, AEWorld.b2NumFromFlxNum(height)/2.0);
			
			//TODO: make fixture attrs overridable
			_fixDef.density = _density;
			_fixDef.restitution = _restitution;
			_fixDef.friction = _friction;                        
			_fixDef.shape = boxShape;
			
			//TODO: make body attrs overridable
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set(x + (AEWorld.b2NumFromFlxNum(width)/2.0), y + (AEWorld.b2NumFromFlxNum(height)/2.0));
			_bodyDef.angle = _angle * (Math.PI / 180);
			_bodyDef.type = _type;
			
			_obj = AEWorld.AEB2World.CreateBody(_bodyDef);
			_obj.CreateFixture(_fixDef);
			
			FlxG.watch(_obj.GetPosition(), "x");
			FlxG.watch(_obj.GetPosition(), "y");
		}
		
		override public function kill():void
		{
			AEWorld.AEB2World.DestroyBody(this._obj);
			super.kill();
		}
		
		public function get_obj():b2Body
		{
			return _obj;
		}
	}
}