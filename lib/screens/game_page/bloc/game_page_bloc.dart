import 'package:bloc/bloc.dart';
import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/bloc/game_page_events.dart';
import 'package:example_app/screens/game_page/bloc/game_page_state.dart';
import 'package:example_app/utils/ai_utils.dart';
import 'package:example_app/utils/game_util.dart';

class GamePageBloc extends Bloc<GamePageEvent,GamePageState>{
  GamePageBloc(GamePageState initialState) : super(initialState) {
    on<TilePress>((event, emit) {
      List<int> board = event.board;
      Player currentPlayer = event.currentPlayer;

      if(event.currentPlayer.playerType==PlayerTypeEnum.HUMAN) {
        int index = event.index??0;
        board[index] = currentPlayer.number;
      }
      else{
        int aiIndex=AiUtils.getBestMove(board, currentPlayer.number).index;
        board[aiIndex]=currentPlayer.number;
      }
        int winner = GameUtil.evaluateBoard(board);
      switch (winner) {
        case 0:
          {
            if (currentPlayer == event.playerOne)
              currentPlayer = event.playerTwo;
            else
              currentPlayer = event.playerOne;
            print(NextMoveState(currentPlayer, board).toString());
            emit(NextMoveState(currentPlayer, board));
          }
          break;
        case 1 :
          {
            print(GameWinState(currentPlayer, board).toString());
            emit(GameWinState(currentPlayer, board));
          }
          break;
        case 2 :
          {
            print(GameWinState(currentPlayer, board).toString());
            emit(GameWinState(currentPlayer, board));
          }
          break;
        case 3 :
          {
            print(GameDrawState(board).toString());
            emit(GameDrawState(board));
          }
          break;
      }
    });
    on<RestartGame>((event, emit) {
      List<int> board = List.generate(9, (int index) => 0);
      Player playerOne=event.playerOne;
      emit(InitState(playerOne, board));
    });
  }
}