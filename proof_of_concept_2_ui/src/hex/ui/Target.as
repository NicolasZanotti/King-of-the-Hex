package hex.ui
{
	import com.greensock.data.TweenMaxVars;

	import stoletheshow.core.ITextdisplayable;

	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Target extends Sprite implements ITextdisplayable
	{
		public var tf:TextField
		public var bt:SimpleButton
		public var bg:MovieClip;
		public var isOccupiedBy:Drag
		protected var _glowTween:TweenMaxVars
		protected var _blurTween:TweenMaxVars
		protected var _isGlowing:Boolean = false
		protected var _isHovering:Boolean = false

		public function Target()
		{
			bt.enabled = false;

			_glowTween = new TweenMaxVars()
			_glowTween.glowFilter(30, 30, 0x91e600)

			_blurTween = new TweenMaxVars()
			_blurTween.glowFilter(0, 0, 0x91e600)
		}

		public function get text():String
		{
			return tf.text;
		}

		public function set text(s:String):void
		{
			tf.text = s;
		}

		public function set hovering(isHovering:Boolean):void
		{
			_isHovering = isHovering;

			if (_isHovering)
			{
				if (!_isGlowing && isOccupiedBy == null)
				{
					_isGlowing = true;
					TweenMax.to(bg, 1, _glowTween);
				}
			}
			else if (_isGlowing)
			{
				_isGlowing = false;
				TweenMax.to(bg, 1, _blurTween);
			}
		}

		public function get isHovering():Boolean
		{
			return _isHovering;
		}
	}
}
