package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import Collisions.AECollisionData;
	
	public class HealthDrop extends B2FlxSprite
	{
		[Embed(source='res/red-bubble.png')]
		public static var ImgAttackBubble:Class;
		
		private var bodyWidth:int = 64;
		private var bodyHeight:int = 64;
		public var owner:HealthDrop;
		public var creatureType:Number;
		public var timeCreated:Number;
		
		public var adaptationType:Number;
		public var pos:b2Vec2;
		private var bubbleBoxShape:b2PolygonShape;
		private var polygonVerticies:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(0.0),AEWorld.b2NumFromFlxNum(-16.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(8.0),AEWorld.b2NumFromFlxNum(-14.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(18.0),AEWorld.b2NumFromFlxNum(-10.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(21.0),AEWorld.b2NumFromFlxNum(0.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(18.0),AEWorld.b2NumFromFlxNum(7.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(8.0),AEWorld.b2NumFromFlxNum(13.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(0.0),AEWorld.b2NumFromFlxNum(14.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-10.0),AEWorld.b2NumFromFlxNum(13.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-17.0),AEWorld.b2NumFromFlxNum(7.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-21.0),AEWorld.b2NumFromFlxNum(0.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-14.0),AEWorld.b2NumFromFlxNum(-10.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-11.0),AEWorld.b2NumFromFlxNum(-14.0)));
		
		public function HealthDrop(x:Number, y:Number)
		{
			this.bubbleBoxShape = new b2PolygonShape();
			this.bubbleBoxShape.SetAsArray(polygonVerticies);
			this.creatureType = SpriteType.HEALTHDROP;
			this.owner = this;
			//this.color = 0xffff0000;
			this.timeCreated = (new Date()).getTime();
			
			super(x, y, 0, ImgAttackBubble, width, height, this.bubbleBoxShape);		
		}
		
		override public function update():void{
			super.update();
			if ((new Date()).getTime() - this.timeCreated > 3600) {
				this.kill();
			}
		}		
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withShape(shape)
				.withType(b2Body.b2_staticBody)
				.withData(new AECollisionData(SpriteType.HEALTHDROP, this));
			return b2bb;
		}
		
		public function getID():Number {
			return -1;
		}
	}
}