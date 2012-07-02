package hex.ui
{
	import com.greensock.TweenMax;
	import com.greensock.easing.SineInOut;
	import com.greensock.data.TweenMaxVars;
	import stoletheshow.display.Textdisplayable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Drag extends Sprite implements Textdisplayable
	{
		public var tf:TextField
		public var bt:SimpleButton
		public var previousPosition:Point;
		public var isPlacedOn:Target

		public function Drag()
		{
			previousPosition = new Point(x, y);
		}

		public function animateToOriginalPosition():void
		{
			var tween:TweenMaxVars = new TweenMaxVars();
			tween.x(previousPosition.x)
			tween.y(previousPosition.y)
			tween.ease(SineInOut)

			var duration:Number = distanceFromOriginalPosition * 0.001

			TweenMax.to(this, duration, tween)
		}

		/* ------------------------------------------------------------------------------- */
		/*  Getters and Setters */
		/* ------------------------------------------------------------------------------- */
		public function get text():String
		{
			return tf.text;
		}

		public function set text(s:String):void
		{
			tf.text = s;
		}

		public function get distanceFromOriginalPosition():Number
		{
			return Point.distance(previousPosition, new Point(x, y))
		}
	}
}
