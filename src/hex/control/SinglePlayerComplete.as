package hex.control
{
	import hex.model.ApplicationState;

	import stoletheshow.control.Controllable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class SinglePlayerComplete extends Sprite implements Controllable
	{
		public var ct:LinkedController;
		public var message:TextField;
		public var btHome:SimpleButton;

		public function SinglePlayerComplete()
		{
			ct = new LinkedController(this);
		}

		// ---------------------------------------------------------------------
		// Event Handlers
		// ---------------------------------------------------------------------
		private function onBthomeClick(event:MouseEvent):void
		{
			event.stopPropagation();
			ct.locator.appState.state = ApplicationState.HOME;
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btHome, MouseEvent.CLICK, onBthomeClick);

			// Bind properties
			var percent:uint = ct.locator.players.currentPlayer.percentageRight;

			if (percent == 100)
			{
				message.text = "You got 100% of the answers correct." + "\n" + "Rank: Hexzilla";
			}
			else if (percent >= 80)
			{
				message.text = "You got " + percent + "% of the answers correct." + "\n" + "Rank: Hexmaestro";
			}
			else if (percent >= 50)
			{
				message.text = "You got " + percent + "% of the answers correct." + "\n" + "Rank: Hex Code Corporal";
			}
			else if (percent == 0)
			{
				message.text = "You got none of the answers correct." + "\n" + "Rank: Colooser";
			}
			else
			{
				message.text = "You got " + percent + "% of the answers correct." + "\n" + "Rank: Hexabismal";
			}
		}

		public function dispose():void
		{
			ct = null;
		}
	}
}
