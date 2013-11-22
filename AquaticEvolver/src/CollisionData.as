package
{
	public class CollisionData
	{
		public var owner:Creature;
		public var colliderType:Number;
		public var adaptation:Adaptation;
		
		public function CollisionData(owner:Creature, type:Number, adapt:Adaptation=null)
		{
			this.owner = owner;
			this.colliderType = type;
			this.adaptation = adapt;
		}
	}
}