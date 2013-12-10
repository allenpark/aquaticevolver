package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Collisions.AECollisionData;
	
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;

	public class AttackBubble extends B2FlxSprite
	{
		[Embed(source='res/Bubble1.png')]
		public static var ImgAttackBubble:Class;
		
		private var bodyWidth:int = 64;
		private var bodyHeight:int = 64;
		
		private var creature:AECreature;
		private var appendage:Appendage;

		public var attackDamage:Number;
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
		
		public function AttackBubble(pos:b2Vec2, width:Number, height:Number, attackDamage:Number, creature:AECreature, appendage:Appendage, speed:Number, targetPoint:FlxPoint)

		{
			this.attackDamage = attackDamage;
			//this.loadGraphic(ImgAttackBubble, false, false);
			this.pos = pos;
			this.bubbleBoxShape = new b2PolygonShape();
			this.bubbleBoxShape.SetAsArray(polygonVerticies);
			this.creature = creature;
			this.appendage = appendage;
			super(AEWorld.flxNumFromB2Num(pos.x), AEWorld.flxNumFromB2Num(pos.y),0, ImgAttackBubble, width, height, this.bubbleBoxShape, -creature.getID());
		}
		override public function update():void{
			if (!this.onScreen(null))
			{
				trace("Offscreen bubble killed!");
				this.kill();
				return;
			}
			super.update();
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withShape(shape)
				.withType(b2Body.b2_kinematicBody)
				.withData(new AECollisionData(SpriteType.BUBBLE, this, this.appendage, this.creature));
			return b2bb;
		}
	}
}