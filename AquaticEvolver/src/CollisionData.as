package
{
	public class CollisionData
	{
		public var owner:*;
		public var colliderType:Number;
		public var adaptation:Adaptation;
		
		public function CollisionData(owner:*, type:Number, adapt:Adaptation=null)
		{
			this.owner = owner;
			this.colliderType = type;
			this.adaptation = adapt;
		}
	}
}