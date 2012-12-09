package hex.model
{
	/**
	 * Object Factory for App-wide elements.
	 * @author Nicolas Zanotti
	 */
	public class Locator
	{
		protected var _appState:ApplicationState
		protected var _hasAppState:Boolean = false
		protected var _main:Main

		public function Locator(main:Main)
		{
			_main = main;
		}

		public function get appState():ApplicationState
		{
			if (!_hasAppState)
			{
				_appState = new ApplicationState(_main)
				_hasAppState = true
			}
			
			return _appState
		}

		public function get main():Main
		{
			return _main;
		}
	}
}