package hex.model
{
	import hex.model.Color;

	/**
	 * @author Nicolas Zanotti
	 */
	public class RandomColor extends Color
	{
		public function RandomColor()
		{
			super(Math.random() * 0xFFFFFF);
		}
	}
}