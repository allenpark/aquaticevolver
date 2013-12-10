package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Collisions.AECollisionData;
	
	import Creature.AECreature;
	
	public class BoxSpike extends B2FlxSprite
	{
		private var bodyWidth:int = 20/2;
		private var bodyHeight:int = 88/2;
		public var creature:AECreature;
		public var appendage:Appendage;
		public static var polygonVerteces:Array = new Array(
			new b2Vec2(AEWorld.b2NumFromFlxNum(-3.5),AEWorld.b2NumFromFlxNum(42.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-8.5),AEWorld.b2NumFromFlxNum(36.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(-9.5),AEWorld.b2NumFromFlxNum(26.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(0),AEWorld.b2NumFromFlxNum(-42.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(10.5),AEWorld.b2NumFromFlxNum(26.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(8.5),AEWorld.b2NumFromFlxNum(36.0)),
			new b2Vec2(AEWorld.b2NumFromFlxNum(4.5),AEWorld.b2NumFromFlxNum(42.0)));
			
		
		public function BoxSpike(x, y, creature:AECreature, appendage:Appendage, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			this.creature = creature;
			this.appendage = appendage;
			super(x, y, 0, Graphic, width, height, null, -creature.getID());			
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsArray(polygonVerteces);
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle).withShape(boxShape)
				.withLinearDamping(2).withData(new AECollisionData(SpriteType.SPIKE, this, appendage, this.creature));
			return b2bb;
		}
	}
}
