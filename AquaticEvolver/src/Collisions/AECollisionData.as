package Collisions
{
	import Box2D.Dynamics.b2Body;
	
	import Creature.AECreature;

	public class AECollisionData
	{
		public var spriteType:Number;
		public var b2FlxSprite:B2FlxSprite;
		public var adaptation:Adaptation;
		public var creature:AECreature;

		
		public function AECollisionData(spriteType:Number, b2FlxSprite:B2FlxSprite, adapt:Adaptation=null, creature:AECreature=null)
		{
			this.spriteType = spriteType;
			this.b2FlxSprite = b2FlxSprite;
			this.adaptation = adapt;
			this.creature = creature;
		}
		public function toString():String
		{
			//TODO: remake this
			return "Collision Data \n\tOwner: " + this.creature + "; ColliderType: " + this.spriteType + "; Adaptation: " + this.adaptation; 
		}
	}
}