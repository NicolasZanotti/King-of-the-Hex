package hex.model
{
	/**
	 * @author Nicolas Zanotti
	 */
	public class Players
	{
		protected var _totalPlayers:uint;
		protected var _playerIndex:uint = 0;
		protected var _players:Array;
		protected var _rounds:uint;

		public function Players(totalPlayers:uint, rounds:uint = 2)
		{
			_totalPlayers = totalPlayers;
			_rounds = rounds;
			_players = [];

			if (_totalPlayers == 1)
			{
				_players.push(new Player(new ColorValues().values));
			}
			else
			{
				var emptyValues:Array = [];
				emptyValues.length = rounds;

				for (var i:int = 0, n:int = _totalPlayers; i < n; i++)
				{
					_players.push(new Player(emptyValues));
					_players[i].name = "Player " + (i + 1);
				}
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

		public function nextPlayer():void
		{
			_playerIndex = (_playerIndex + 1) % _players.length;
		}

		public function resetPlayerIndex():void
		{
			_playerIndex = 0;
		}

		public function get currentPlayer():Player
		{
			return _players[_playerIndex] as Player;
		}
		/*
		protected function get previousPlayer():Player
		{
		return _players[(_playerIndex < 1 ? _players.length - 1 : _playerIndex - 1)];
		}*/
	}
}
