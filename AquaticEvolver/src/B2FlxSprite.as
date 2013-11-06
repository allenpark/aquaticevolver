package
{
	import org.flixel.FlxSprite;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import org.flixel.*;
	
	import org.flixel.FlxG;
	
	public class B2FlxSprite extends FlxSprite
	{
		////////////////////////      box2d traits      ///////////////////////////
		
		protected var _fixDef:b2FixtureDef;
		protected var _bodyDef:b2BodyDef
		protected var _obj:b2Body;
		
		//Physics params default value
		protected var _friction:Number = 0.8;
		protected var _restitution:Number = 0.3;
		protected var _density:Number = 0.7;
		
		//Default angle
		protected var _angle:Number = 0;
		//Default body type
		protected var _type:uint = b2Body.b2_dynamicBody;
		
		public function B2FlxSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			createBody();
		}
		
		override public function update():void
		{
			x = ((_obj.GetPosition().x * World.RATIO) - width/2.0);
			y = ((_obj.GetPosition().y * World.RATIO) - height/2.0);
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
		}
		
		public function createBody():void
		{            
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox((width/2.0) / World.RATIO, (height/2.0) / World.RATIO);
			
			_fixDef = new b2FixtureDef();
			_fixDef.density = _density;
			_fixDef.restitution = _restitution;
			_fixDef.friction = _friction;                        
			_fixDef.shape = boxShape;
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((x + (width/2.0))/ World.RATIO, (y + (height/2.0)) / World.RATIO);
			_bodyDef.angle = _angle * (Math.PI / 180);
			_bodyDef.type = _type;
			
			_obj = World.box2dWorld.CreateBody(_bodyDef);
			_obj.CreateFixture(_fixDef);
			
			FlxG.watch(_obj.GetPosition(), "x");
			FlxG.watch(_obj.GetPosition(), "y");
		}
	}
}