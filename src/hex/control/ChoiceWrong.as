package hex.control
{
	import hex.ui.Patch;

	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ChoiceWrong extends Choice
	{
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

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		override public function init():void
		{
			// Configure listeners
			ct.events.add(btNext, MouseEvent.CLICK, onBtnextClick);

			chosen.color = ct.locator.players.currentPlayer.chosen;
			given.color = ct.locator.players.currentPlayer.given;

			// Bind properties
			chosenValue.text = ct.locator.players.currentPlayer.chosen.octal
			givenValue.text = ct.locator.players.currentPlayer.given.octal
		}
	}
}