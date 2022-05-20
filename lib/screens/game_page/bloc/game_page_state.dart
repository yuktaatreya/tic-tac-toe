import 'package:equatable/equatable.dart';

import 'package:example_app/entities/player_model.dart';

abstract class GamePageState  extends Equatable {
  late Player activePlayer;
  late List<int> board;


}

class InitState extends GamePageState {
  Player _activePlayer;
  List<int> _board;
  InitState(this._activePlayer,this._board);
  @override
  Player get activePlayer =>_activePlayer;
  @override
  List<int> get board =>_board;

  @override
  List<Object?> get props => [_activePlayer,_board];
}

class NextMoveState extends GamePageState {
  Player _activePlayer;
  List<int> _board;
  NextMoveState(this._activePlayer,this._board);
  @override
  Player get activePlayer =>_activePlayer;
  @override
  List<int> get board =>_board;

  @override
  List<Object?> get props => [_activePlayer,_board];
}

class GameWinState extends GamePageState {
  Player _activePlayer;
  List<int> _board;
  GameWinState(this._activePlayer,this._board);
  @override
  Player get activePlayer =>_activePlayer;
  @override
  List<int> get board =>_board;
  @override
  List<Object?> get props => [_activePlayer,_board];
}

class GameDrawState extends GamePageState {
  List<int> _board;
  GameDrawState(this._board);
  @override
  List<int> get board =>_board;
  @override
  List<Object?> get props => [_board];
}