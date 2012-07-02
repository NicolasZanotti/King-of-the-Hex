package hex.model
{
	import stoletheshow.model.Color;

	import flash.errors.IllegalOperationError;

	/**
	 * @author Nicolas Zanotti
	 */
	public class MultiplayerState implements PlayerState
	{
		protected var _totalPlayers:uint;
		protected var _playerIndex:uint = 0;
		protected var _players:Array;
		protected var _rounds:uint;

		public function MultiplayerState(totalPlayers:uint, rounds:uint = 2)
		{
			_totalPlayers = totalPlayers;

			// add one because nextColor is called when starting
			_rounds = rounds;

			var dummyValues:Array = [];
			dummyValues.length = rounds;

			_players = [];

			for (var i:int = 0, n:int = _totalPlayers; i < n; i++)
			{
				_players.push(new SinglePlayerState(dummyValues));
				_players[i].name = "Player " + (i + 1);
			}
		}

		/**
		 * If there are more rounds in the game.
		 */
		public function get hasNextRound():Boolean
		{
			return _rounds > 0;
		}

		public function nextRound():void
		{
			_rounds -= 1;
		}

		public function nextPlayer():SinglePlayerState
		{
			_playerIndex = (_playerIndex + 1) % _players.length;
			return currentPlayer;
		}

		public function resetPlayerIndex():void
		{
			_playerIndex = 0;
		}

		protected function get currentPlayer():SinglePlayerState
		{
			return _players[_playerIndex] as SinglePlayerState;
		}

		protected function get previousPlayer():SinglePlayerState
		{
			return _players[(_playerIndex < 1 ? _players.length - 1 : _playerIndex - 1)];
		}
		
		
		/* ------------------------------------------------------------------------------- */
		/*  Wrapper methods for SinglePlayerState */
		/* ------------------------------------------------------------------------------- */
		
		public function get percentageRight():uint { return currentPlayer.percentageRight; }
		
		public function get nextColor():Color { return previousPlayer.chosen; }

		public function get name():String { return currentPlayer.name; }
		
		public function set name(s:String):void { throw new IllegalOperationError("Names are set in the constructor"); }
		
		public function get given():Color { return currentPlayer.given; }

		public function set given(given:Color):void { currentPlayer.given = given; }

		public function get chosen():Color { return currentPlayer.chosen; }

		public function set chosen(chosen:Color):void { currentPlayer.chosen = chosen; }

		public function incrementCorrectAnswers():void { currentPlayer.incrementCorrectAnswers(); }

		public function incrementWrongAnswers():void { currentPlayer.incrementWrongAnswers(); }
	}
}
