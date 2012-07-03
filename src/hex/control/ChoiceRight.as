package hex.control
{
	import hex.model.Player;
	import hex.model.Players;
	import hex.model.ApplicationState;
	import hex.ui.Patch;

	import stoletheshow.control.Controllable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ChoiceRight extends Sprite implements Controllable
	{
		public var ct:LinkedController;
		public var chosen:Patch;
		public var chosenValue:TextField;
		public var btNext:SimpleButton;

		public function ChoiceRight()
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
			if (ct.locator.players is Players)
			{
				(ct.locator.players as Players).nextPlayer();
				ct.locator.appState.state = ct.locator.players.hasNextRound ? ApplicationState.CAMERA_COLORPICKER : ApplicationState.MULTIPLAYER_COMPLETE;
			}
			else if (ct.locator.players is Player)
			{
				ct.locator.appState.state = ct.locator.players.hasNextRound ? ApplicationState.GUESS : ApplicationState.SINGLEPLAYER_COMPLETE;
			}
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btNext, MouseEvent.CLICK, onBtnextClick);

			// Bind properties
			chosen.color = ct.locator.players.currentPlayer.chosen;
			chosenValue.text = ct.locator.players.currentPlayer.chosen.octal;
		}

		public function dispose():void
		{
			ct = null;
		}
	}
}
