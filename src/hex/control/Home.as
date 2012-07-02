package hex.control
{
	import hex.model.ColorValues;
	import hex.model.SinglePlayerState;
	import hex.model.MultiplayerState;
	import hex.model.ApplicationState;

	import stoletheshow.control.Controllable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Home extends Sprite implements Controllable
	{
		public var ct:LinkedController;
		public var btPractice:SimpleButton;
		public var btCompete:SimpleButton;

		public function Home()
		{
			ct = new LinkedController(this);
		}

		// ---------------------------------------------------------------------
		// Event Handlers
		// ---------------------------------------------------------------------
		private function onBtpracticeClick(event:MouseEvent):void
		{
			event.stopPropagation();
			onCreateNewSinglePlayerGame();
		}

		private function onBtcompeteClick(event:MouseEvent):void
		{
			event.stopPropagation();
			onCreateNewMultiplayerGame();
		}

		protected function onCreateNewMultiplayerGame():void
		{
			ct.locator.playerState = new MultiplayerState(2);
			ct.locator.appState.state = ApplicationState.CAMERA_COLORPICKER;
		}

		protected function onCreateNewSinglePlayerGame():void
		{
			ct.locator.playerState = new SinglePlayerState(new ColorValues().values);
			ct.locator.appState.state = ApplicationState.GUESS;
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btPractice, MouseEvent.CLICK, onBtpracticeClick);
			ct.events.add(btCompete, MouseEvent.CLICK, onBtcompeteClick);
		}

		public function dispose():void
		{
			ct = null;
		}
	}
}