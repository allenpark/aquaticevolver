package Creature.Images
{
	public class AEImage
	{
		protected var _img:Class;
		
		protected var _width:Number;
		protected var _height:Number;
		
		public function AEImage(Graphic:Class, width:Number, height:Number)
		{
			_img = Graphic;
			_width = width;
			_height = height;
		}
		
		public function getImg():Class
		{
			return _img;
		}
		
		public function getWidth():Number
		{
			return _width;
		}
		
		public function getHeight():Number
		{
			return _height;
		}
	}
}