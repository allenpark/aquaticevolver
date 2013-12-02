package
{
	import B2Builder.B2BodyBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import Creature.AECreature

	public class AttackBubble extends B2FlxSprite
	{
		[Embed(source='res/Bubble1.png')]
		public static var ImgAttackBubble:Class;
		
		private var bodyWidth:int = 64;
		private var bodyHeight:int = 64;
		public var owner:AECreature;
		public var adaptOwner:Adaptation;
		public var pos:b2Vec2;
		
		public function AttackBubble(pos:b2Vec2, owner:AECreature, adaptOwner:Adaptation, width:Number, height:Number, speed:Number, targetPoint:FlxPoint)
		{
			//this.loadGraphic(ImgAttackBubble, false, false);
			this.owner = owner;
			this.adaptOwner = adaptOwner;
			this.pos = pos;
			super(AEWorld.flxNumFromB2Num(pos.x), AEWorld.flxNumFromB2Num(pos.y),0, ImgAttackBubble, width, height);
		}
		override public function update():void{
			if (!this.onScreen(null))
			{
				this.kill();
				return;
			}
			super.update();
		}
		
		override protected function bodyBuilder(position:b2Vec2, angle:Number, shape:b2PolygonShape = null):B2BodyBuilder
		{
			var b2bb:B2BodyBuilder = super.bodyBuilder(position, angle)
				.withType(b2Body.b2_kinematicBody)
				.asBullet()
				.withData(new CollisionData(this.owner, SpriteType.BUBBLE, adaptOwner));
			return b2bb;
		}
	}
}