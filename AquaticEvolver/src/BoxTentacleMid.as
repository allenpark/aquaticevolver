package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	
	import Creature.AECreature;

	public class BoxTentacleMid extends B2FlxSprite
	{
		private var bodyWidth:int = 24/2;
		private var bodyHeight:int = 40/2;
		public var creature:AECreature;
		public var adaptOwner:Adaptation;
		
		public function BoxTentacleMid(x:Number, y:Number, creature:AECreature, adaptOwner:Adaptation, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			trace("Constructing tentacle mid");
			this.creature = creature;
			this.adaptOwner = adaptOwner;
			super(x, y, 0, Graphic, width, height, null, -creature.getID());
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle).withShape(boxShape)
				.withLinearDamping(2)
				.withData(new CollisionData(this.creature, SpriteType.TENTACLEMID, this.adaptOwner));
			return b2bb;
		}
	}
}
