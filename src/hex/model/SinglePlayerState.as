package hex.model
{
	import stoletheshow.model.Color;

	/**
	 * @author Nicolas Zanotti
	 */
	public class SinglePlayerState implements PlayerState
	{
		protected var _values:Array;
		protected var _valuesIndex:uint = 0;
		protected var _name:String;
		/*
		 * Progress tracking
		 */
		protected var _correctAnswersAmount:int = 0
		protected var _falseAnswersAmount:int = 0;
		/*
		 * Ingame colors
		 */
		protected var _given:Color;
		protected var _chosen:Color;

		public function SinglePlayerState(colorValues:Array)
		{
			_values = colorValues;
		}

		public function incrementWrongAnswers():void
		{
			_falseAnswersAmount += 1;
		}
		
		/* ------------------------------------------------------------------------------- */
		/*  Getters and setters */
		/* ------------------------------------------------------------------------------- */
		public function get nextColor():Color
		{
			_valuesIndex += 1;
			return new Color(_values[_valuesIndex]);
		}

		public function get hasNextRound():Boolean
		{
			return _valuesIndex < _values.length
		}

		public function incrementCorrectAnswers():void
		{
			_correctAnswersAmount += 1;
		}

		public function get percentageRight():uint
		{
			var percent:Number = Math.round(_correctAnswersAmount * 100 / _values.length)

			if (percent < 0) throw new Error("Less than 0%");
			else if (percent > 100) throw new Error("More than 100%")

			return percent
		}

		public function get given():Color { return _given; }

		public function set given(given:Color):void { _given = given; }

		public function get chosen():Color{ return _chosen; }

		public function set chosen(chosen:Color):void { _chosen = chosen; }

		public function get name():String { return _name; }
		
		public function set name(s:String):void { _name = s; }
	}
}
