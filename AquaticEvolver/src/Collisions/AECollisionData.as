package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AECollisionData
	{
		public var spriteType:Number;
		public var b2FlxSprite:B2FlxSprite;
		public var appendage:Appendage;
		public var creature:AECreature;

		
		public function AECollisionData(spriteType:Number, b2FlxSprite:B2FlxSprite, appendage:Appendage=null, creature:AECreature=null)
		{
			this.spriteType = spriteType;
			this.b2FlxSprite = b2FlxSprite;
			this.appendage = appendage;
			this.creature = creature;
		}
		public function toString():String
		{
			//TODO: remake this
			return "Collision Data \n\tspriteType: " + this.spriteType + "; b2FlxSprite: " + this.b2FlxSprite + "; appendage: " + this.appendage + "; creature: " + this.creature; 
		}
	}
}