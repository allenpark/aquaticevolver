package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	
	import Creature.Images.DefaultImage;
	import Creature.Images.Head1;
	import Creature.Images.Head2;
	import Creature.Images.Head3;
	import Creature.Images.Head4;
	import Creature.Images.Head5;
	import Creature.Images.Tail1;
	import Creature.Images.Tail2;
	import Creature.Images.Tail3;
	import Creature.Images.Tail4;
	import Creature.Images.Tail5;
	import Creature.Images.Torso1;
	import Creature.Images.Torso2;
	import Creature.Images.Torso3;
	import Creature.Images.Torso4;
	import Creature.Images.Torso5;
	import Creature.Schematics.AESchematic;
	
	import Def.AEHeadDef;
	import Def.AESegmentDef;
	import Def.AETailDef;
	import Def.AETorsoDef;
	
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	public class AECreature
	{		
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
		
		public var currentHealth:int;
		public var maxHealth:int;
		public var healthDisplay:FlxText;
		public var speed:Number = 10;
		protected var killed:Boolean;
		
		
		public function AECreature(type:Number, x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			//Set creature id, then increment current id value
			trace("constructing creature with id:" + getID());
			var id:Number = this.getID();
			_head = headDef.createHeadWithCreatureID(id);
			_torso = torsoDef.createTorsoWithCreatureID(id);
			_tail = tailDef.createTailWithCreatureID(id);
			
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
			this.healthDisplay = new FlxText(0, 0, 50);
			this.healthDisplay.size = 10;
			this.killed = false;
		}
		
		public function getID():Number
		{
			return undefined;
		}
		
		// This method is called often to update the state of the creature.
		public function update():void {
			this.healthDisplay.x = getX() - 5;
			this.healthDisplay.y = getY() + 10;
			// added code for when the enemey current ratio of health 
			// is lower then the health threshold, it turns red
			var threshold:Number = 1.0;
			var healthRatio:Number = this.currentHealth * 1.0 / this.maxHealth;
			if (healthRatio <= threshold ) {
				var redColor:Number = 0xffff0000;
				var whiteColor:Number = 0xffffffff;
				var ratio:Number = int(healthRatio * 16) / 16.0;
				this.color(redColor * (1 - ratio) + whiteColor * ratio);
			}
			this.healthDisplay.text = this.currentHealth + "/" + this.maxHealth;
			//			this.adaptationGroup.setAll("x", this.x + 10);
			
			//			this.adaptationGroup.setAll("y", this.y);			
			//for (var i:int = 0; i < this.adaptationGroup.length; i++) {
			//this.adaptationGroup.members[i].update();
			//}
			/*for (var i:int = 0; i < this.adaptations.length; i++) {
			this.adaptations[i].update();
			}*/
		}
		
		public function addAdaptation(adaptationType:Number):Boolean
		{
			
			// if the adaptation is not an appendage
			if (!AdaptationType.isAppendage(adaptationType))
			{
				var adaptation:Adaptation = Adaptation.createAdaptationWithType(adaptationType,this);
				_adaptations.push(adaptation);
				return true;
			}
			else
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
					var appendage:Appendage = Appendage.createAppendageWithType(adaptationType,appendageSlot.slotLocation, angle, this, appendageSlot.segment);
					//TODO: keep track of appendages... in adaptations array? or separate appendage array?
					_occupiedAppendageSlots.push(appendageSlot);
					_adaptations.push(appendage);
					return true;
				}
			}
		}
		
		public function handleAttackOn(adaptation:Adaptation, enemy:AECreature):Boolean {
			var enemyDead:Boolean = false;
			if (adaptation == null) {// || adaptation.adaptationType == SpriteType.SHELL) {
				enemyDead = enemy.getAttacked(0);
			} else {
				enemyDead = enemy.getAttacked(adaptation.attackDamage);	
			}
			
			/*if (!enemyAlive) {
			//this.inheritFrom(enemy);
			if (adaptation != null)	{
			adaptation.attackDamage += 2;					
			}
			return true;
			}
			return false;*/
			return enemyDead;
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
			if (this.killed) {
				return;
			}
			this.killed = true;
			_head.kill();
			_torso.kill();
			_tail.kill();
			trace("KILLING ENEMY");
			
			if (this._adaptations.length != 0) {
				//Get random adaptation
				var randomAdaptation:Number = this._adaptations[int(Math.random()*(this._adaptations.length - 1))].adaptationType;
				
				//Add evolution drop
				var evolutionDrop:EvolutionDrop = new EvolutionDrop(getX(), getY(), randomAdaptation);
				
				//Add to world
				AEWorld.world.add(evolutionDrop);
			}
			
			//Get first appendage
			//var appendage = Appendage.createAppendageWithType(AppendageType.SPIKE		
			
			healthDisplay.kill();
			for each(var adaptation:Adaptation in _adaptations) {
				if (adaptation != null) {
					adaptation.kill();
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
		
		private function color(color:Number):void {
			_head.color(color);
			_torso.color(color);
			_tail.color(color);
			for each (var adaptation:Adaptation in _adaptations) {
				adaptation.color(color);
			}
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
		
		public static function randomHeadDef(x:Number, y:Number):AEHeadDef
		{
			var headImages:Array = new Array(new Head1(), new Head2(), new Head3(), new Head4(), new Head5());
			var randomHeadImage:DefaultImage = headImages[int(Math.random()*headImages.length)]
			return headDef(x,y,randomHeadImage);
		}
		
		private static function headDef(x:Number, y:Number, headImage:DefaultImage):AEHeadDef
		{
			var headSchematic:AESchematic = new AESchematic(headImage.image(), headImage.suggestedAppendageSlots());
			var playerHeadShape:b2PolygonShape = new b2PolygonShape();
			playerHeadShape.SetAsArray(headImage.polygonVertices());
			var playerHeadSegmentDef:AESegmentDef = new AESegmentDef(x,y, headSchematic, playerHeadShape);
			var playerHeadDef:AEHeadDef = new AEHeadDef(playerHeadSegmentDef, headImage.suggestedHeadAnchor());
			return playerHeadDef;
		}
		
		protected static function head1Def(x:Number, y:Number):AEHeadDef
		{
			return headDef(x, y, new Head1());
		}
		
		protected static function head2Def(x:Number, y:Number):AEHeadDef
		{
			return headDef(x, y, new Head2());
		}
		
		protected static function head3Def(x:Number, y:Number):AEHeadDef
		{
			return headDef(x, y, new Head3());
		}
		
		protected static function head4Def(x:Number, y:Number):AEHeadDef
		{
			return headDef(x, y, new Head4());
		}
		
		protected static function head5Def(x:Number, y:Number):AEHeadDef
		{
			return headDef(x, y, new Head5());
		}
		
		public static function randomTorsoDef(x:Number, y:Number):AETorsoDef
		{
			var torsoImages:Array = new Array(new Torso1(), new Torso2(), new Torso3(), new Torso4(), new Torso5());
			var randomTorsoImage:DefaultImage = torsoImages[int(Math.random()*torsoImages.length)]
			return torsoDef(x,y,randomTorsoImage);
		}
		
		/**
		 * IMPORTANT: Only for single segment torsos
		 */
		private static function torsoDef(x, y, torsoImage:DefaultImage):AETorsoDef
		{
			var torsoSchematic:AESchematic = new AESchematic(torsoImage.image(), torsoImage.suggestedAppendageSlots());
			var playerTorsoShape:b2PolygonShape = new b2PolygonShape();
			playerTorsoShape.SetAsArray(torsoImage.polygonVertices());
			var playerTorsoSegmentDef:AESegmentDef = new AESegmentDef(x,y, torsoSchematic, playerTorsoShape);
			var playerTorsoSegmentDefs:Array = new Array(playerTorsoSegmentDef);
			var playerTorsoDef:AETorsoDef = new AETorsoDef(torsoImage.suggestedHeadAnchor(), playerTorsoSegmentDefs, torsoImage.suggestedTailAnchor());
			return playerTorsoDef;
		}
		
		protected static function torso1Def(x:Number, y:Number):AETorsoDef
		{
			return torsoDef(x, y, new Torso1());
		}
		
		protected static function torso2Def(x:Number, y:Number):AETorsoDef
		{
			return torsoDef(x, y, new Torso2());
		}
		
		protected static function torso3Def(x:Number, y:Number):AETorsoDef
		{
			return torsoDef(x, y, new Torso3());
		}
		
		protected static function torso4Def(x:Number, y:Number):AETorsoDef
		{
			return torsoDef(x, y, new Torso4());
		}
		
		protected static function torso5Def(x:Number, y:Number):AETorsoDef
		{
			return torsoDef(x, y, new Torso5());
		}
		
		public static function randomTailDef(x:Number, y:Number):AETailDef
		{
			var tailImages:Array = new Array(new Tail1(), new Tail2(), new Tail3(), new Tail4(), new Tail5());
			var randomTailImage:DefaultImage = tailImages[int(Math.random()*tailImages.length)]
			return tailDef(x,y,randomTailImage);
		}
		
		private static function tailDef(x:Number, y:Number, tailImage:DefaultImage):AETailDef
		{
			var tailSchematic:AESchematic = new AESchematic(tailImage.image(), tailImage.suggestedAppendageSlots());
			var playerTailShape:b2PolygonShape = new b2PolygonShape();
			playerTailShape.SetAsArray(tailImage.polygonVertices());
			var playerTailSegmentDef:AESegmentDef = new AESegmentDef(x, y, tailSchematic, playerTailShape);
			var playerTailDef:AETailDef = new AETailDef(playerTailSegmentDef, tailImage.suggestedTailAnchor());
			return playerTailDef;
		}
		
		protected static function tail1Def(x:Number, y:Number):AETailDef
		{
			return tailDef(x, y, new Tail1());
		}
		
		protected static function tail2Def(x:Number, y:Number):AETailDef
		{
			return tailDef(x, y, new Tail2());
		}
		
		protected static function tail3Def(x:Number, y:Number):AETailDef
		{
			return tailDef(x, y, new Tail3());
		}
		
		protected static function tail4Def(x:Number, y:Number):AETailDef
		{
			return tailDef(x, y, new Tail4());
		}
		
		protected static function tail5Def(x:Number, y:Number):AETailDef
		{
			return tailDef(x, y, new Tail5());
		}
	}
}
