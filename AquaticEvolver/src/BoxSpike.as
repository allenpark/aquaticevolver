package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;
	
	public class BoxSpike extends B2FlxSprite
	{
		private var bodyWidth:int = 20/2;
		private var bodyHeight:int = 88/2;
		public var creature:AECreature;
		
		public function BoxSpike(x, y, creature:AECreature, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			this.creature = creature;
			super(x, y, 0, Graphic, width, height, null, -creature.getID());			
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle).withShape(boxShape)
				.withLinearDamping(2).withData(new CollisionData(this.creature, SpriteType.SPIKE));
			return b2bb;
		}
	}
}
