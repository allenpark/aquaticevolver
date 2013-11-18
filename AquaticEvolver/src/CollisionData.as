package
{
	public class CollisionData
	{
		public var owner:Creature;
		public var colliderType:Number;
		
		public function CollisionData(owner:Creature, type:Number)
		{
			this.owner = owner;
			this.colliderType = type;
		}
	}
}