package hex.model
{
	import stoletheshow.model.Color;

	/**
	 * @author Nicolas Zanotti
	 */
	public class Players
	{
		protected var _totalPlayers:uint;
		protected var _playerIndex:uint = 0;
		protected var _players:Array;
		protected var _rounds:uint;
		protected var _currentRound:uint = 1;

		public function Players(totalPlayers:uint, rounds:uint)
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
			trace('_rounds: ' + (_rounds));
			return _rounds > 0;
		}

		public function nextRound():void
		{
			_currentRound += 1;
			_rounds -= 1;
		}

		public function nextPlayer():void
		{
			_playerIndex = nextPlayerIndex;
		}

		public function resetPlayerIndex():void
		{
			_playerIndex = 0;
		}

		public function set selectedColorForNextPlayer(color:Color):void
		{
			var next:Player = _players[nextPlayerIndex] as Player;

			next.values[_currentRound - 1] = color.value;
			trace('next.values: ' + (next.values));
		}

		public function get isMultiPlayer():Boolean
		{
			return _players.length > 1;
		}

		public function get currentPlayer():Player
		{
			return _players[_playerIndex] as Player;
		}

		private function get nextPlayerIndex():uint
		{
			return (_playerIndex + 1) % _players.length;
		}
		/*
		protected function get previousPlayer():Player
		{
		return _players[(_playerIndex < 1 ? _players.length - 1 : _playerIndex - 1)];
		}*/
	}
}
