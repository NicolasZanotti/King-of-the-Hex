package hex.control
{
	import hex.model.ApplicationState;

	import stoletheshow.control.Controllable;
	import stoletheshow.mediators.CameraColorPickerMediator;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Nicolas Zanotti
	 */
	public class CameraColorPicker extends Sprite implements Controllable
	{
		protected var ct:LinkedController;
		protected var mediator:CameraColorPickerMediator;
		public var videoContainer:MovieClip;
		public var btStop:SimpleButton;
		public var colorValue:TextField;
		public var message:TextField;
		public var btStart:SimpleButton;
		public var btNext:SimpleButton;

		public function CameraColorPicker()
		{
			ct = new LinkedController(this);
		}

		// ---------------------------------------------------------------------
		// Event Handlers
		// ---------------------------------------------------------------------
		protected function onBtnextClick(event:MouseEvent):void
		{
			event.stopPropagation();
			ct.locator.players.selectedColorForNextPlayer = mediator.color;
			ct.locator.players.nextPlayer();
			ct.locator.appState.state = ApplicationState.GUESS;
		}

		protected function onBtStopClick(event:MouseEvent):void
		{
			event.stopPropagation();
			btNext.visible = true;
		}

		// ---------------------------------------------------------------------
		// Controller Methods
		// ---------------------------------------------------------------------
		public function init():void
		{
			// Configure listeners
			ct.events.add(btNext, MouseEvent.CLICK, onBtnextClick);
			ct.events.add(btStop, MouseEvent.CLICK, onBtStopClick)

			// Bind properties
			mediator = new CameraColorPickerMediator(videoContainer, btStart, btStop).withColorValueDisplay(colorValue);
			message.text = "Player " + ct.locator.players.currentPlayer.name + ", choose a color using your camera";

			// Restore state
			btNext.visible = false;
		}

		public function dispose():void
		{
			mediator = null;
			ct = null;
		}
	}
}
