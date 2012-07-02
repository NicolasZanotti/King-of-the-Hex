package hex.model
{
	import stoletheshow.display.StateChangeable;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ApplicationState implements StateChangeable
	{
		protected var _main:Main;
		/*
		 * Frame labels
		 */
		public static const INTERNAL_LOADER:String = "INTERNAL_LOADER";
		public static const EXTERNAL_LOADER:String = "EXTERNAL_LOADER";
		public static const ERROR:String = "ERROR";
		public static const HOME:String = "HOME";
		public static const GUESS:String = "GUESS";
		public static const CAMERA_COLORPICKER:String = "CAMERA_COLORPICKER";
		public static const CHOICE_RIGHT:String = "CHOICE_RIGHT";
		public static const CHOICE_WRONG:String = "CHOICE_WRONG";
		public static const SINGLEPLAYER_COMPLETE:String = "SINGLEPLAYER_COMPLETE";
		public static const MULTIPLAYER_COMPLETE:String = "MULTIPLAYER_COMPLETE";

		public function ApplicationState(main:Main)
		{
			_main = main;
		}

		/* ------------------------------------------------------------------------------- */
		/*  Getters and setters */
		/* ------------------------------------------------------------------------------- */
		public function get state():String
		{
			return _main.state;
		}

		public function set state(name:String):void
		{
			_main.state = name;
		}
	}
}