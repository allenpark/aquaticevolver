package
{
	import org.flixel.*;
	
	
	public class pausescreen extends FlxGroup
	{
		
		
		private var _bg:FlxSprite;
		
		
		private var _field:FlxText;
		
		private var _fields:FlxText;
		
		
		public var showing:Boolean;
		
		internal var _displaying:Boolean;
		
		public var pic1:FlxSprite;
		
		public var pic2:FlxSprite;
		
		
		private var _finishCallback:Function;
		
		[Embed(source='res/spike.png')]
		public var spike:Class;
		
		[Embed(source='res/tentacle.png')]
		public var tentacle:Class;
		
		
		public function pausescreen()
		{
			
			
			_bg = new FlxSprite(30,30).makeGraphic(260, 200, 0xff808080);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(_bg);
			
			
			_field = new FlxText(-40,40, 410, "Paused");
			_field.setFormat(null, 12, 0xff00FFFF, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			_fields = new FlxText(-100,_bg.y+50, 410, "Apendage Obtained");
			_fields.setFormat(null, 12, 0xff00FFFF, "center");
			_fields.scrollFactor.x = _fields.scrollFactor.y = 0;
			add(_fields);
			
			pic1 = new FlxSprite(_bg.x,_bg.y+70);
			pic1.loadGraphic(spike, true, true, 14, 15);
			pic1.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(pic1);
			
			pic2 = new FlxSprite(_bg.x + 30,_bg.y+70);
			pic2.loadGraphic(tentacle, true, true, 14, 15);
			pic2.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(pic2);
			
			
		}
		
		/**
		 * Call this from your code to display some dialog
		 */
		
		
		public function displayPaused():void
		{
			FlxG.paused = true;
			_displaying = true;
			showing = true;
		}
		
		/**
		 * The meat of the class. Used to display text over time as well
		 * as control which page is 'active'
		 */
		override public function update():void
		{
			if(FlxG.paused)
				//if (_displaying)
			{
				{
					_field.text = "Paused";
				}
				if(FlxG.keys.justPressed("P"))
				{
					FlxG.music.resume();
					this.kill();
					this.exists = false;
					showing = false;
					_displaying = false;
					FlxG.paused = false;
					//if (_finishCallback != null) _finishCallback();
					
				} 
				else
				{
					
					showing = true;
					_displaying = true;
					FlxG.paused = true;
					
				}
				
				super.update();
			}	
		}
		
		/**
		 * Called when the dialog is completely finished
		 */
		/*
		public function set finishCallback(val:Function):void
		{
		_finishCallback = val;
		}
		*/
		
	}
}