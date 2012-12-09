package hex.control
{
	import stoletheshow.core.IControllable;
	import flash.display.Sprite;

	/**
	 * @author Nicolas Zanotti
	 */
	public class GameChoiceRight extends Sprite implements IControllable
	{
		protected var ct:LinkedController
		
		public function GameChoiceRight()
		{
			ct = new LinkedController(this)
		}

		public function init():void
		{
			trace("this is the right choice!")
		}

		public function dispose():void
		{
		}
	}
}
