package hex.control
{
	import stoletheshow.core.IControllable;
	import flash.display.Sprite;

	/**
	 * @author Nicolas Zanotti
	 */
	public class GameChoiceWrong extends Sprite implements IControllable
	{
		protected var ct:LinkedController
		
		public function GameChoiceWrong()
		{
			ct = new LinkedController(this)
		}

		public function init():void
		{
			trace("this is the wrong choice")
		}

		public function dispose():void
		{
		}
	}
}
