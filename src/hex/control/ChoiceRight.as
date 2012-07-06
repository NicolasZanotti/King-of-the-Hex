package hex.control
{
	import hex.ui.Patch;

	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class ChoiceRight extends Choice
	{
		public var chosen:Patch;
		public var chosenValue:TextField;
		public var btNext:SimpleButton;

		public function ChoiceRight()
		{
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

			// Bind properties
			chosen.color = ct.locator.players.currentPlayer.chosen;
			chosenValue.text = ct.locator.players.currentPlayer.chosen.octal;
		}
	}
}
