package hex.model
{
	import stoletheshow.model.Color;

	/**
	 * @author Nicolas Zanotti
	 */
	public interface PlayerState
	{
		function get given():Color;

		function set given(col:Color):void;

		function get chosen():Color;

		function set chosen(col:Color):void;

		function incrementCorrectAnswers():void;

		function incrementWrongAnswers():void;

		function get hasNextRound():Boolean;

		function get nextColor():Color;

		function get name():String;

		function get percentageRight():uint;
	}
}