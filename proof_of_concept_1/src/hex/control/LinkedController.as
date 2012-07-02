package hex.control
{
	import hex.model.Locator;
	import stoletheshow.control.EventsController;
	import stoletheshow.core.IControllable;


	/**
	 * Link the controller to the models
	 *
	 * @author Nicolas Zanotti
	 */
	public class LinkedController extends EventsController
	{
		public function LinkedController(owner : IControllable)
		{
			super(owner);
		}

		public function get locator() : Locator
		{
			return (owner.root as Main).locator;
		}
	}
}