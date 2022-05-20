import 'package:example_app/utils/game_util.dart';

class AiUtils{
  static const int WIN_SCORE=100;
  static const  int DRAW_SCORE=-50;
  static const int LOSE_SCORE=-100;
  static const int CONTINUE=0;

  static int getScore(List<int> board, int currentPlayer){
    int boardState =GameUtil.evaluateBoard(board);
    if(boardState==currentPlayer)
      return WIN_SCORE;
    if(boardState==3)
      return DRAW_SCORE;
    if(boardState==GameUtil.flipPlayer(currentPlayer))
      return LOSE_SCORE;
    return CONTINUE;
  }

  static Move getBestMove(List<int>board,int currentPlayer){
    List<int> newBoard;
    Move bestMove=Move(-1, -1000);

    for (int currentMove=0; currentMove<board.length;currentMove++){
      if(!GameUtil.isMoveLegal(board, currentMove))
        continue;
      newBoard=List.from(board);
      newBoard[currentMove]=currentPlayer;
      int score = getScore(newBoard, GameUtil.flipPlayer(currentPlayer));
      int nextScore;
      if(score!=CONTINUE)
        nextScore = -score;
      else
        nextScore= -getBestMove(newBoard, GameUtil.flipPlayer(currentPlayer)).score;
      if(nextScore>bestMove.score){
        bestMove.score=nextScore;
        bestMove.index=currentMove;
      }
    }
    return bestMove;
  }
}
class Move {
  int score;
  int index;
  Move(this.index, this.score);
}
