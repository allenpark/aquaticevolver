package Creature
{
	import B2Builder.B2RevoluteJointBuilder;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	
	import Creature.Def.AEHeadDef;
	import Creature.Def.AESegmentDef;
	import Creature.Def.AETailDef;
	import Creature.Def.AETorsoDef;
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
	
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import FlxColor;
	
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
		
		
		public var currentHealth:int;
		public var maxHealth:int;
		public var healthDisplay:FlxText;
		public var speed:Number = 10;
		protected var killed:Boolean;
		public var flashingHealthState:Number = 0;
		public var flashingEvoState:Number = 0;
		public var flashingInvincibleState:Number = 0;
		public var invincibleTimer:Number = 0;
		public var invFlashFrame:Number = 0;
		public var flashFrame:Number = 0;
		public var lastAddedAdaptation:String;
		public var evoGainCount:Number;
		public var killCount:Number;
		
		
		public function AECreature(x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			//Set creature id, then increment current id value
			//trace("constructing creature with id:" + getID());
			var id:Number = this.getID();
			_head = headDef.createHeadWithCreatureID(id);
			_torso = torsoDef.createTorsoWithCreatureID(id);
			_tail = tailDef.createTailWithCreatureID(id);
			
			_adaptations = new Array();
			
			//TODO: is having a null torso vaild? eg. head-tail architecture?
			attachHeadTorsoTail();
			
			initializeAppendageSlots();
			
			ownBodies();
			//TODO: Should this be done outside the constructor?
			addToWorld();
			
			currentHealth = health;
			maxHealth = health;
			this.healthDisplay = new FlxText(0, 0, 50);
			this.healthDisplay.size = 10;
			this.killed = false;
			evoGainCount = 0;
			killCount = 0;
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
			
			if (flashingHealthState == 1) {
				var greenColor:Number = 0xff00ff00;
				var currentColor:Number = 0xffff0000 * (1 - (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0))
					+ 0xffffffff * (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0);
				this.color(FlxColor.interpolateColor(greenColor, currentColor, 16, flashFrame));
				this.flashFrame += 1;
				if (flashFrame == 15) flashingHealthState = 2;
			}
			if (flashingHealthState == 2) {
				var greenColor:Number = 0xff00ff00;
				var currentColor:Number = 0xffff0000 * (1 - (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0))
					+ 0xffffffff * (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0);
				this.color(FlxColor.interpolateColor(greenColor, currentColor, 16, flashFrame));
				this.flashFrame -= 1;
				if (flashFrame == 0) flashingHealthState = 3;
			}
			if (flashingHealthState == 3) {
				this.flashFrame += 1;
				if (flashFrame == 15) {
					flashFrame = 0;
					flashingHealthState = 0;
				}
			}
			if (flashingEvoState == 1) {
				var yellowColor:Number = 0xffffff00;
				var currentColor:Number = 0xffff0000 * (1 - (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0))
					+ 0xffffffff * (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0);
				this.color(FlxColor.interpolateColor(yellowColor, currentColor, 16, flashFrame));
				this.flashFrame += 1;
				if (flashFrame == 15) flashingEvoState = 2;
			}
			if (flashingEvoState == 2) {
				var yellowColor:Number = 0xffffff00;
				var whiteColor:Number = 0xffffffff;
				var ratio:Number = int(flashFrame) / 16.0;
				this.color(yellowColor * (ratio) + whiteColor * (1 - ratio));
				this.flashFrame -= 1;
				if (flashFrame == 0) flashingEvoState = 3;
			}
			if (flashingEvoState == 3) {
				this.flashFrame += 1;
				if (flashFrame == 15) {
					flashFrame = 0;
					flashingEvoState = 0;
				}
			}
			
			// invincibility should last one second
			if (flashingInvincibleState > 0 && flashingInvincibleState <= 3) {
				var darkColor:Number = 0xff882222;
				var currentColor:Number = 0xffff0000 * (1 - (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0))
					+ 0xffffffff * (int((this.currentHealth * 1.0 / this.maxHealth) * 16) / 16.0);
				this.color(FlxColor.interpolateColor(darkColor, currentColor, 16, invFlashFrame));
				this.invFlashFrame += 1;
				if (this.invFlashFrame == 15) {
					this.invFlashFrame = 0;
					this.flashingInvincibleState += 1;
				}
				if (this.flashingInvincibleState == 4) { // Only do this flashy thing three times
					this.invFlashFrame = 0;
					this.flashingInvincibleState = 0;
				}
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
		
		private function weakestAppendageSlot():AESlot
		{
			var weakestAppendageSlot:AESlot;
			for each (var appendageSlot:AESlot in this._occupiedAppendageSlots)
			{
				var appendage:Appendage = appendageSlot.appendage;
				if (!weakestAppendageSlot)
				{
					weakestAppendageSlot = appendageSlot;
				}
				else if (appendageSlot.appendage.attackDamage <= weakestAppendageSlot.appendage.attackDamage)
				{
					weakestAppendageSlot = appendageSlot;
				}
			}
			return weakestAppendageSlot;
		}
		
		public function gainAdaptation(adaptationType:Number):void {
			this.addAdaptation(adaptationType);
			this.flashingEvoState = 1;
			this.flashingHealthState = 0;
			this.flashFrame = 0;
			this.lastAddedAdaptation = AdaptationType.toString(adaptationType);
			this.evoGainCount += 1;
		}
		
		public function healCreature():void {
			this.flashingHealthState = 1;
			this.flashingEvoState = 0;
			this.flashFrame = 0;
			this.lastAddedAdaptation = AdaptationType.toString(AdaptationType.HEALTHINCREASE);
			if (this.currentHealth < this.maxHealth) {
				var healthRegain:int = this.maxHealth - this.currentHealth;
				this.currentHealth += healthRegain;
			}
		}
		
		protected function addAdaptation(adaptationType:Number):Boolean
		{
			
			// if the adaptation is not an appendage
			if (!AdaptationType.isAppendage(adaptationType))
			{
				var adaptation:Adaptation = Adaptation.createAdaptationWithType(adaptationType,this);
				_adaptations.push(adaptation);
				if (adaptationType == AdaptationType.SPEEDINCREASE) {
					this.speed += 5;
				}
				return true;
			}
			else
			{

				if (_unoccupiedAppendageSlots.length == 0)
				{
					//var weakestAppendageSlot:AESlot = this.weakestAppendageSlot();
					
					//TODO: Evolve a bigger body & attach the new appendage!
					var weakestAppendageSlot:AESlot = this.weakestAppendageSlot();
					trace("***** WAS:"+weakestAppendageSlot);
					var angle:Number = Math.atan2(weakestAppendageSlot.slotLocation.y, weakestAppendageSlot.slotLocation.x) + Math.PI/2;
					weakestAppendageSlot.appendage.kill();
					trace("weakest appendage killed in sacrifice to darwin");
					var newAppendage:Appendage = Appendage.createAppendageWithType(adaptationType,weakestAppendageSlot.slotLocation, angle, this, weakestAppendageSlot.segment);
					weakestAppendageSlot.appendage = newAppendage;
					_adaptations.push(newAppendage);
					
					return false;
				}
				else
				{
					var appendageSlot:AESlot = _unoccupiedAppendageSlots[int(Math.random()*(this._unoccupiedAppendageSlots.length - 1))];
					_unoccupiedAppendageSlots.splice(_unoccupiedAppendageSlots.indexOf(appendageSlot),1);
					//TODO: appendage locations need to be rotated with body
					//TODO: Fix angle for appendages
					var angle:Number = Math.atan2(appendageSlot.slotLocation.y, appendageSlot.slotLocation.x) + Math.PI/2;

					var appendage:Appendage = Appendage.createAppendageWithType(adaptationType,appendageSlot.slotLocation, angle, this, appendageSlot.segment);
					//TODO: keep track of appendages... in adaptations array? or separate appendage array?
					appendageSlot.appendage = appendage;
					_occupiedAppendageSlots.push(appendageSlot);
					_adaptations.push(appendage);
					return true;
				}
			}
		}
		
		// returns if creature is killed
		public function takeDamage(damage:Number):Boolean
		{
			if (this.flashingInvincibleState == 0) {
				this.currentHealth -= damage;
				
				// Make play less bursty, add invincibility frames when the player takes damage
				this.flashingInvincibleState = 1;
				
				if (this == AEWorld.player)
				{
					//this is for the sound effect
					AEWorld.world.playerInDanger = true;
				}
				if (this.currentHealth <= 0) {
					this.currentHealth = 0;
					if (this == AEWorld.player)
					{
						AEWorld.world.gameOver();
					}
					return this.kill();
				}
			}
			return false;
		}
		
		/*
		*** OLD IMPLEMENTATION ***
		public function handleAttackOn(adaptation:Adaptation, enemy:AECreature):Boolean {
		var enemyDead:Boolean = false;
		if (adaptation == null) {// || adaptation.adaptationType == SpriteType.SHELL) {
		enemyDead = enemy.getAttacked(0);
		} else {
		enemyDead = enemy.getAttacked(adaptation.attackDamage);	
		}
		
		
		//if (!enemyAlive) {
		////this.inheritFrom(enemy);
		//if (adaptation != null)	{
		//adaptation.attackDamage += 2;					
		//}
		//return true;
		//}
		//return false;
		return enemyDead;
		}
		*/
		
		/*
		*** OLD IMPLEMENTATION ***
		public function getAttacked(damage:int):Boolean {
		this.currentHealth -= damage;
		if (this.currentHealth <= 0) {
		this.currentHealth = 0;
		this.kill();
		return true;
		}
		return false;
		}
		*/
		
		public function kill():Boolean
		{
			if (this.killed) {
				return false;
			}
			this.killed = true;
			_head.kill();
			_torso.kill();
			_tail.kill();
			
			var generator:Number = Math.random();
			if (generator < .5) {
				//Get random adaptation
				if (this._adaptations.length != 0) {
					//Get random adaptation
					var randomAdaptation:Number = this._adaptations[int(Math.random()*(this._adaptations.length - 1))].adaptationType;
					
					//Add evolution drop
					var evolutionDrop:EvolutionDrop = new EvolutionDrop(getX(), getY(), randomAdaptation);
					
					//Add to world
					AEWorld.world.add(evolutionDrop);
				}
			} else if (generator > .5) {
				var healthDrop:HealthDrop = new HealthDrop(getX(), getY());
				AEWorld.world.add(healthDrop);
			}
			
			healthDisplay.kill();
			AEWorld.world.remove(healthDisplay);
			for each(var adaptation:Adaptation in _adaptations) {
				if (adaptation != null) {
					adaptation.kill();
				}
			}
			return true;
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
		
		private function ownBodies():void
		{
			_head.ownBodies(this);
			_torso.ownBodies(this);
			_tail.ownBodies(this);
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
