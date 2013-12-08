package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	
	import Creature.Images.Head1;
	import Creature.Images.Tail1;
	import Creature.Images.Torso1;
	import Creature.Schematics.AESchematic;
	
	import Def.AEHeadDef;
	import Def.AESegmentDef;
	import Def.AETailDef;
	import Def.AETorsoDef;
			
	public class AECreature
	{
		protected var _id:Number;
		
		protected var _head:AEHead;
		protected var _torso:AETorso;
		protected var _tail:AETail;
		
		protected var _adaptations:Array;
		
		private var _unoccupiedAppendageSlots:Array;
		private var _occupiedAppendageSlots:Array;
		
		protected var _headTorsoJoint:b2RevoluteJoint;
		protected var _torsoTailJoint:b2RevoluteJoint;
		
		private static const HeadSwivel:Number = Math.PI/2.0;
		private static const TailSwivel:Number = Math.PI/2.0;
		
		public var creatureType:Number;
		
		public var x:Number;
		public var y:Number;
		protected var currentHealth:int;
		protected var maxHealth:int;
		protected var speed:Number = 10;
		
		
		public function AECreature(type:Number, x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			//Set creature id, then increment current id value
			trace("constructing creature with id:" + getID());
			_head = headDef.createHeadWithCreatureID(getID());
			_torso = torsoDef.createTorsoWithCreatureID(getID());
			_tail = tailDef.createTailWithCreatureID(getID());

			_adaptations = new Array();
			
			creatureType = type;
			//TODO: is having a null torso vaild? eg. head-tail architecture?
			attachHeadTorsoTail();
			
			initializeAppendageSlots();
			
			ownBodies(type);
			//TODO: Should this be done outside the constructor?
			addToWorld();
			
			currentHealth = health;
			maxHealth = health;
		}
		
		public function getID():Number
		{
			return undefined;
		}
		
		public function attachAppendage(appendageType:Number):Boolean
		{
			if (_unoccupiedAppendageSlots.length == 0)
			{
				//TODO: Evolve a bigger body & attack the new appendage!
				return false;
			}
			else
			{
				var appendageSlot:AESlot = _unoccupiedAppendageSlots.pop();
				//TODO: appendage locations need to be rotated with body
				var angle:Number = Math.atan2(appendageSlot.slotLocation.y, appendageSlot.slotLocation.x) + Math.PI/2;
				//TODO: Fix angle for appendages
				var appendage:Appendage = Appendage.createAppendageWithType(appendageType,appendageSlot.slotLocation, angle, this, appendageSlot.segment);
				//TODO: keep track of appendages... in adaptations array? or separate appendage array?
				_occupiedAppendageSlots.push(appendageSlot);
				_adaptations.push(appendage);
				return true;
			}
		}
		
		public function handleAttackOn(adaptation:Adaptation, enemy:AECreature):Boolean {
			var enemyAlive:Boolean = false;
			if (adaptation == null) {
				enemyAlive = enemy.getAttacked(0);
			} else {
				enemyAlive = enemy.getAttacked(adaptation.attackDamage);	
			}
			
			/*if (!enemyAlive) {
				//this.inheritFrom(enemy);
				if (adaptation != null)	{
					adaptation.attackDamage += 2;					
				}
				return true;
			}
			return false;*/
			return true;
		}
		
		public function getAttacked(damage:int):Boolean {
			this.currentHealth -= damage;
			if (this.currentHealth <= 0) {
				this.currentHealth = 0;
				this.kill();
				return true;
			}
			return false;
		}
		
		public function kill():void
		{
			_head.kill();
			_torso.kill();
			_tail.kill();
			for each(var adaptation:Adaptation in _adaptations){
				if (adaptation != null)
				{
					adaptation.kill();
				}
				else{
				}
			}
		}
		
		public function getX():Number
		{
			return AEWorld.flxNumFromB2Num(_head.headSegment.getBody().GetPosition().x);
		}
		
		public function getY():Number
		{
			return AEWorld.flxNumFromB2Num(_head.headSegment.getBody().GetPosition().y);
		}
		
		private function ownBodies(type:Number):void
		{
			_head.ownBodies(this,type);
			_torso.ownBodies(this,type);
			_tail.ownBodies(this,type);
		}
		
		private function addToWorld():void
		{
			_head.addToWorld();
			_torso.addToWorld();
			_tail.addToWorld();
		}
		
		private function attachHeadTorsoTail():void
		{
			//TODO: Should Head -- Torso -- Tail attaching with weld joints be included?? Currently, only revolute joints are used to connect head-torso-tail together
			
			//Head -- Torso
			_headTorsoJoint = new B2RevoluteJointBuilder(_head.headSegment.getBody(), _torso.headSegment.getBody(), _head.headAnchor, _torso.headAnchor)
				.withEnabledLimit().withSwivelAngle(HeadSwivel)
				.build();
						
			//Torso -- Tail
			_torsoTailJoint = new B2RevoluteJointBuilder(_torso.tailSegment.getBody(), _tail.tailSegment.getBody(), _torso.tailAnchor, _tail.tailAnchor)
				.withEnabledLimit().withSwivelAngle(TailSwivel)
				.build();
		}
		
		private function initializeAppendageSlots():void
		{
			_unoccupiedAppendageSlots = new Array()
				.concat(_head.getAppendageSlots())
				.concat(_torso.getAppendageSlots())
				.concat(_tail.getAppendageSlots());
			
			_occupiedAppendageSlots = new Array();
		}
		
		
		//Should probably be moved up to the AECreature class
		protected static function head1Def(x:Number, y:Number):AEHeadDef
		{
			var headSchematic:AESchematic = new AESchematic(Head1.image(), Head1.suggestedAppendageSlots);
			//Setting up the segment's shape
			var playerHeadShape:b2PolygonShape = new b2PolygonShape();
			playerHeadShape.SetAsArray(Head1.polygonVerteces);
			var playerHeadSegmentDef:AESegmentDef = new AESegmentDef(x,y, headSchematic, playerHeadShape); //TODO: HeadSegment should have modified height/width... current dimensions make head and tail touch and prevent swiveling
			var playerHeadDef:AEHeadDef = new AEHeadDef(playerHeadSegmentDef, Head1.suggestedHeadAnchor);
			return playerHeadDef;
		}
		//Should probably be moved up to the AECreature class
		protected static function torso1Def(x:Number, y:Number):AETorsoDef
		{
			var torsoSchematic:AESchematic = new AESchematic(Torso1.image(), Torso1.suggestedAppendageSlots);
			//Setting up segment's shape
			var playerTorsoShape:b2PolygonShape = new b2PolygonShape();
			playerTorsoShape.SetAsArray(Torso1.polygonVerteces);
			var playerTorsoSegmentDef:AESegmentDef = new AESegmentDef(x,y, torsoSchematic, playerTorsoShape);
			var playerTorsoSegmentDefs:Array = new Array(playerTorsoSegmentDef);
			var playerTorsoDef:AETorsoDef = new AETorsoDef(Torso1.suggestedHeadAnchor, playerTorsoSegmentDefs, Torso1.suggestedTailAnchor);
			return playerTorsoDef;
		}
		//Should probably be moved up to the AECreature class
		protected static function tail1Def(x:Number, y:Number):AETailDef
		{
			var tailSchematic:AESchematic = new AESchematic(Tail1.image(), Tail1.suggestedAppendageSlots);
			//Setting the segment's shape
			var playerTailShape:b2PolygonShape = new b2PolygonShape();
			playerTailShape.SetAsArray(Tail1.polygonVerteces);
			var playerTailSegmentDef:AESegmentDef = new AESegmentDef(x, y, tailSchematic, playerTailShape);
			var playerTailDef:AETailDef = new AETailDef(playerTailSegmentDef, Tail1.suggestedTailAnchor);
			return playerTailDef;
		}	
	}
}