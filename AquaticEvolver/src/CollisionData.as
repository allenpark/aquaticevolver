package
{
	import Creature.AECreature;

	public class CollisionData
	{
		public var owner:*; // TODO(Allen): Change this to AECreature once appropriate.
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