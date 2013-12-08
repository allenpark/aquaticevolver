package
{	
	import Creature.AECreature;
	
	import Def.AEHeadDef;
	import Def.AETailDef;
	import Def.AETorsoDef;
	
	public class AEEnemy extends AECreature
	{
		public static var enemies:Array;
		
		private static var unusedIDs:Array = new Array(2,3,4,5,6,7,8,9,10,11,12,13,14,15);
		private static var usedIDs:Array = new Array();
		
		private var _id:Number;
		
		public function AEEnemy(id:Number, type:Number, x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			_id = id;
			trace('Enemy created with id:' + _id);
			super(type, x, y, health, headDef, torsoDef, tailDef);
		}
		
		public static function generateEnemy(x:Number, y:Number):AEEnemy
		{
			if (unusedIDs.length != 0)
			{
				var id:Number = unusedIDs.pop();
				var newEnemy:AEEnemy = new AEEnemy(id, SpriteType.ENEMY, x, y, 10, AECreature.head1Def(x,y), AECreature.torso1Def(x,y), AECreature.tail1Def(x,y));
				usedIDs.push(id);
				AEEnemy.enemies.push(newEnemy);
				return newEnemy;
			}else {
				for each (var enemy:AEEnemy in enemies)
				{
					if (AEWorld.world.outOfBounds(AEWorld.flxNumFromB2Num(enemy.getX()), AEWorld.flxNumFromB2Num(enemy.getY())))
					{
						enemy.kill();
						// try again
						return generateEnemy(x,y);
					}
				}
				return null;
			}
		}
		
		override public function getID():Number
		{
			return _id;
		}
		
		override public function update():void{		
			this.x = this.getX();
			this.y = this.getY();
			super.update();
		}
		
		override public function kill():void
		{
			unusedIDs.push(_id);
			super.kill();
		}
	}
}