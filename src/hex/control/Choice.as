package hex.control
{
	import hex.model.ApplicationState;

	import stoletheshow.control.Controllable;

	import flash.display.Sprite;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Choice extends Sprite implements Controllable
	{
		public var ct:LinkedController;

		public function Choice()
		{
			ct = new LinkedController(this);
		}

		public function init():void
		{
		}

		public function dispose():void
		{
			ct = null;
		}

		protected function onNextLevel():void
		{
			
			if (ct.locator.players.isMultiPlayer)
			{
				ct.locator.players.nextRound();
				ct.locator.appState.state = ct.locator.players.hasNextRound ? ApplicationState.CAMERA_COLORPICKER : ApplicationState.MULTIPLAYER_COMPLETE;
			}
			else
			{
				ct.locator.players.nextRound();
				ct.locator.appState.state = ct.locator.players.hasNextRound ? ApplicationState.GUESS : ApplicationState.SINGLEPLAYER_COMPLETE;
			}
		}
	}
}
