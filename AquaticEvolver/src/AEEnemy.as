package
{	
	import Creature.AECreature;
	
	import Def.AEHeadDef;
	import Def.AETailDef;
	import Def.AETorsoDef;
	
	public class AEEnemy extends AECreature
	{
		public static var enemies:Array;
		public function AEEnemy(type:Number, x:Number, y:Number, health:Number, headDef:AEHeadDef, torsoDef:AETorsoDef, tailDef:AETailDef)
		{
			super(type, x, y, health, headDef, torsoDef, tailDef);
		}
		
		public static function generateDefaultEnemy(x:Number, y:Number):AEEnemy
		{
			var newEnemy:AEEnemy = new AEEnemy(SpriteType.ENEMY, x, y, 10, AECreature.head1Def(x,y), AECreature.torso1Def(x,y), AECreature.tail1Def(x,y));
			AEEnemy.enemies.push(newEnemy);
			return newEnemy;
		}
	}
}