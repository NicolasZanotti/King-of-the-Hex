package hex.control
{
	import stoletheshow.core.IControllable;
	import stoletheshow.events.ControllerEvent;

	import flash.display.Sprite;

	/**
	 * @author Julien Villiger
	 */
	public class ClickEater extends Sprite implements IControllable
	{
		private var _ct:LinkedController;

		public function ClickEater()
		{
			_ct = new LinkedController(this);
		}

		/* ------------------------------------------------------------------------------- */
		/*  Event Handlers */
		/* ------------------------------------------------------------------------------- */
		private function onLock(e:ControllerEvent = null):void
		{
			visible = true;
		}

		private function onUnlock(e:ControllerEvent = null):void
		{
			visible = false;
		}

		/* ------------------------------------------------------------------------------- */
		/*  Controller Methods */
		/* ------------------------------------------------------------------------------- */
		public function init():void
		{
			// Configure listeners
			_ct.events.add(stage, ControllerEvent.INTERFACE_LOCK, onLock);
			_ct.events.add(stage, ControllerEvent.INTERFACE_UNLOCK, onUnlock);
			
			// Restore state
			onUnlock();
		}

		public function dispose():void
		{
		}
	}
}