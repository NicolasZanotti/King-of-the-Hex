package hex.control
{
	import hex.model.ApplicationState;
	import hex.model.MultiplayerState;
	import hex.model.SinglePlayerState;
	import hex.ui.Patch;

	import stoletheshow.control.Controllable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ChoiceWrong extends Sprite implements Controllable
	{
		public var ct:LinkedController;
		public var chosen:Patch;
		public var given:Patch;
		public var chosenValue:TextField;
		public var givenValue:TextField;
		public var btNext:SimpleButton;

		public function ChoiceWrong()
		{
			ct = new LinkedController(this);
		}

		// ---------------------------------------------------------------------
		// Event Handlers
		// ---------------------------------------------------------------------
		private function onBtnextClick(event:MouseEvent):void
		{
			event.stopPropagation();
			onNextLevel();
		}

		protected function onNextLevel():void
		{
			if (ct.locator.playerState is MultiplayerState)
			{
				(ct.locator.playerState as MultiplayerState).nextPlayer();
				ct.locator.appState.state = ct.locator.playerState.hasNextRound ? ApplicationState.CAMERA_COLORPICKER : ApplicationState.MULTIPLAYER_COMPLETE;
			}
			else if (ct.locator.playerState is SinglePlayerState)
			{
				ct.locator.appState.state = ct.locator.playerState.hasNextRound ? ApplicationState.GUESS : ApplicationState.SINGLEPLAYER_COMPLETE;
			}
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btNext, MouseEvent.CLICK, onBtnextClick);

			chosen.color = ct.locator.playerState.chosen;
			given.color = ct.locator.playerState.given;

			// Bind properties
			chosenValue.text = ct.locator.playerState.chosen.octal
			givenValue.text = ct.locator.playerState.given.octal
		}

		public function dispose():void
		{
			ct = null;
		}
	}
}
