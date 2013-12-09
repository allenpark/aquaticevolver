package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Creature.AECreature;
	import Collisions.AECollisionData;

	public class BoxMandibleBase extends B2FlxSprite
	{
		private var bodyWidth:int = 36/2;
		private var bodyHeight:int = 42/2;
		public var creature:AECreature;
		public var adaptOwner:Adaptation;
		
		public function BoxMandibleBase(x:Number, y:Number, creature:AECreature, adaptOwner:Adaptation, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			super(x, y, 0, Graphic, width, height, null, -creature.getID());
			this.creature = creature;
			this.adaptOwner = adaptOwner;
		}
		
		override protected function bodyBuilder(position:b2Vec2,angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withShape(boxShape)
				.withLinearDamping(2)
				.withData(new AECollisionData(SpriteType.MANDIBLEBASE, this, this.adaptOwner, this.creature));
			return b2bb;
		}
		
		public function getOwner():AECreature
		{
			return creature;
		}
	}
}