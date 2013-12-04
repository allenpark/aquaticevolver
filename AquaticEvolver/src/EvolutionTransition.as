package
{
	import Creature.AECreature;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * Call to cover up the evolution state when rebuilding a creature
	 * Pass in the AECreature to have the transition follow. Will automatically
	 * follow the player if no creature is passed in.
	 */
	public class EvolutionTransition extends FlxSprite
	{
		private var Graphic:Class; //TODO Add the graphic to display here
		
		private var followingCreature:AECreature;
		/**
		 * Amount scale changes by when increasing or decreasing
		 */
		private const SCALEDELTA:Number = .1;
		/**
		 * Amount of time that will elapse before the image is updated
		 */
		private const TIMEBETWEENCHANGE:Number = .005;
		/**
		 * Max amount of scale that the image will reach before scaling down
		 */
		private const MAXSCALE:Number = 10;
		
		private var updateCounter:Number = 0;
		
		private var numOscillations:Number = 5;
		
		private var oscRange:Number = 20;
								
		private var scaleType:int = 0;
				
		public function EvolutionTransition(creatureToFollow:AECreature = null)
		{
			if(creatureToFollow != null){
				this.followingCreature = AEWorld.player;
			}else{
				this.followingCreature = creatureToFollow;
			}
			super(followingCreature.getX(), followingCreature.getY());
		}
		
		override public function update():void
		{
			updateCounter += FlxG.elapsed;
			//TODO: Center on the player
			this.x = followingCreature.getX();
			this.y = followingCreature.getY();
			//Assure that we wait a certain amount of time before next
			//animation
			if(updateCounter > TIMEBETWEENCHANGE){
				updateCounter = 0;
				switch(scaleType){
					//we are increasing
					case 0:
						if(this.scale.x < MAXSCALE){
							increaseScale();
						}else{
							scaleType = 1;
						}
						break;
					//oscillating
					case 1:
						if(oscRange > 0 && numOscillations > 0){
							decreaseScale();
							oscRange -=1;
						}else if(oscRange <= 0 && numOscillations > 0){
							if(oscRange < -20){
								oscRange = 20;
								numOscillations -= 1;
							}else{
								oscRange -=1;
							}
							increaseScale();
						}else{
							scaleType = 2;
						}
						break;
					case 2:
						if(this.scale.x > 2*SCALEDELTA){
							decreaseScale();
						}else{
							scaleType = 3;
						}
						break;
					//Done showing just kill it
					default:
						this.kill();
						this.destroy();
						break;
				}
			}
		}
		
		public function increaseScale():void{
			this.scale.x += SCALEDELTA;
			this.scale.y += SCALEDELTA;
		}
		
		public function decreaseScale():void{
			this.scale.x -= SCALEDELTA;
			this.scale.y -= SCALEDELTA;
		}
	}
}