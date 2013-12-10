package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Collisions.AECollisionData;
	
	import Creature.AECreature;
	
	public class BoxTentacleHead extends B2FlxSprite
	{
		private var bodyWidth:int = 20/2;
		private var bodyHeight:int = 44/2;
		public var creature:AECreature;
		public var appendage:Appendage;
		
		public function BoxTentacleHead(x:Number, y:Number, creature:AECreature, appendage:Appendage, Graphic:Class=null, width:Number=0, height:Number=0)
		{
			//trace("Constructing tentacle head");
			this.creature = creature;
			this.appendage = appendage;
			super(x, y,0,Graphic, width, height, null, -creature.getID());
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{     
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(AEWorld.b2NumFromFlxNum(bodyWidth), AEWorld.b2NumFromFlxNum(bodyHeight));
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, Math.PI/2).withShape(boxShape)
				.withLinearDamping(2)
				.withData(new AECollisionData(SpriteType.TENTACLEHEAD, this, this.appendage, this.creature));
			return b2bb;
		}
	}
}

