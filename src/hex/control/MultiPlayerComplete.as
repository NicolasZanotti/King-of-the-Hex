package hex.control
{
	import hex.model.MultiplayerState;
	import hex.model.ApplicationState;

	import stoletheshow.control.Controllable;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class MultiPlayerComplete extends Sprite implements Controllable
	{
		public var ct:LinkedController;
		public var btHome:SimpleButton;
		public var tfWinner:TextField;
		public var tfPlayer1Percent:TextField;
		public var tfPlayer2Percent:TextField;

		public function MultiPlayerComplete()
		{
			ct = new LinkedController(this);
		}

		// ---------------------------------------------------------------------
		// Event Handlers
		// ---------------------------------------------------------------------
		protected function onBthomeClick(event:MouseEvent):void
		{
			event.stopPropagation();
			ct.locator.appState.state = ApplicationState.HOME
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btHome, MouseEvent.CLICK, onBthomeClick);

			var s:MultiplayerState = ct.locator.playerState as MultiplayerState

			s.resetPlayerIndex();
			var percentage1:uint = s.percentageRight;
			var name1:String = s.name
			tfPlayer1Percent.text = name1 + ": " + percentage1.toString() + "%";

			s.nextPlayer();
			var percentage2:uint = s.percentageRight
			var name2:String = s.name
			tfPlayer2Percent.text = name2 + ": " + percentage2.toString() + "%";

			if (percentage1 == percentage2)
			{
				tfWinner.text = "It's a tie!"
			}
			else if (percentage1 > percentage2 )
			{
				tfWinner.text = name1 + " wins!"
			}
			else
			{
				tfWinner.text = name2 + " wins!"
			}
		}

		public function dispose():void
		{
			ct = null;
		}
	}
}
