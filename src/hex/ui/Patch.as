package hex.ui
{
	import stoletheshow.model.Color;

	import flash.display.Sprite;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Patch extends Sprite
	{
		protected var _color:Color

		public function set color(col:Color):void
		{
			_color = col;
			transform.colorTransform = _color.colorTransform;
		}

		public function get color():Color
		{
			return _color;
		}
	}
}