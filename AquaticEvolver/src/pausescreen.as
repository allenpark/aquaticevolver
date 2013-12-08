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
		
		
		
		[Embed (source = "res/gamepaused.png")] public var gamePauseText:Class;
		[Embed (source = "res/resume.png")] public var resume:Class;
		[Embed (source = "res/Cursor.png")] public var cursorImg:Class;
		
		
		public function pausescreen()
		{
			
			
			_bg = new FlxSprite(30,30).makeGraphic(1280, 960, 0xff3366ff);
			_bg.scrollFactor.x = _bg.scrollFactor.y = 0;
			add(_bg);
			
			
			
			_field = new FlxText(-40,40, 410, "Paused");
			_field.setFormat(null, 12, 0xff00FFFF, "center");
			_field.scrollFactor.x = _field.scrollFactor.y = 0;
			add(_field);
			
			var gameText:FlxSprite = new FlxSprite(FlxG.width/2 - 250, 0, gamePauseText);
			gameText.scrollFactor.x = gameText.scrollFactor.y = 0 ; 
			add(gameText);
			
			var resumeButton:FlxButton = new FlxButton(FlxG.width/2 - 65, 2*FlxG.height/7.0, "", resumeCallback);
			resumeButton.scrollFactor.x = resumeButton.scrollFactor.y = 0 ;
			resumeButton.loadGraphic(resume);
			add(resumeButton);
			/*
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
			*/
			
		}
		
		public function resumeCallback():void{
				FlxG.music.resume();
				this.exists = false;
				this.showing = false;
				this._displaying = false;
				FlxG.paused = false;
				trace(" in paused");
				this.kill();
				
				//if (_finishCallback != null) _finishCallback();
				
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
					this.exists = false;
					this.showing = false;
					this._displaying = false;
					FlxG.paused = false;
					trace(" in paused");
					this.kill();

					//if (_finishCallback != null) _finishCallback();
					
				} 
				else
				{
					
					this.showing = true;
					this._displaying = true;
					this.exists = true;
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