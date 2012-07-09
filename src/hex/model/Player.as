package hex.model
{
	import stoletheshow.model.Color;

	/**
	 * State for a single player.
	 * 
	 * @author Nicolas Zanotti
	 */
	public class Player
	{
		public var values:Array;
		protected var _valuesIndex:int = -1;
		/*
		 * Progress tracking
		 */
		protected var _correctAnswersAmount:int = 0
		protected var _falseAnswersAmount:int = 0;
		/*
		 * Ingame colors
		 */
		public var given:Color;
		public var chosen:Color;
		public var name:String;

		public function Player(colorValues:Array)
		{
			values = colorValues;
		}

		public function incrementWrongAnswers():void
		{
			_falseAnswersAmount += 1;
		}

		public function incrementCorrectAnswers():void
		{
			_correctAnswersAmount += 1;
		}

		/* ------------------------------------------------------------------------------- */
		/*  Getters and setters */
		/* ------------------------------------------------------------------------------- */
		public function get nextColor():Color
		{
			trace('_valuesIndex (before): ' + (_valuesIndex));
			_valuesIndex += 1;
			return new Color(values[_valuesIndex]);
		}

		public function get percentageRight():uint
		{
			var percent:Number = Math.round(_correctAnswersAmount * 100 / values.length)

			if (percent < 0) throw new Error("Less than 0%");
			else if (percent > 100) throw new Error("More than 100%")

			return percent
		}
	}
}
