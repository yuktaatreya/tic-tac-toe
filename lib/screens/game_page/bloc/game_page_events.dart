import 'package:example_app/entities/player_model.dart';

abstract class GamePageEvent {}

class TilePress extends GamePageEvent {
  int? index;
  Player currentPlayer;
  Player playerOne;
  Player playerTwo;
  List<int> board;
  TilePress({this.index,
    required this.board,
    required this.currentPlayer,
  required this.playerOne,
  required this.playerTwo});
}
class RestartGame extends GamePageEvent{
  Player playerOne;
  RestartGame(this.playerOne);
}