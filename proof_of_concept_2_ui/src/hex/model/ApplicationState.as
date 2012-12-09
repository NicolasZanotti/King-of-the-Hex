package hex.model
{
	import stoletheshow.core.IStateChangeable;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ApplicationState implements IStateChangeable
	{
		protected var _main:Main;
		/*
		 * Frame labels
		 */
		public static const ERROR:String = "ERROR";
		public static const HOME:String = "HOME";
		public static const GAME:String = "GAME";
		public static const GAME_CHOICE_RIGHT:String = "GAME_CHOICE_RIGHT";
		public static const GAME_CHOICE_WRONG:String = "GAME_CHOICE_WRONG";
		/*
		 * Ingame colors
		 */
		public var given:Color;
		public var chosen:Color;
		/*
		 * Progress tracking
		 */
		protected var _correctAnswersAmount:uint = 0

		public function ApplicationState(main:Main)
		{
			_main = main;
		}

		/* ------------------------------------------------------------------------------- */
		/*  Getters and setters */
		/* ------------------------------------------------------------------------------- */
		public function get correctAnswersAmount():uint
		{
			return _correctAnswersAmount
		}
		
		public function get state():String
		{
			return _main.state;
		}

		public function set state(name:String):void
		{
			if (name == GAME_CHOICE_RIGHT) _correctAnswersAmount++
			
			_main.state = name;
		}
	}
}