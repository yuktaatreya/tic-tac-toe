import 'package:example_app/constants/app_strings.dart';
import 'package:example_app/screens/game_page/bloc/game_page_state.dart';
import 'package:flutter/material.dart';

import '../entities/player_symbol_enum.dart';

class GameUtil {
  static int evaluateBoard(List<int> board) {
    List<List<int>> winningMoves = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var list in winningMoves) {
      if (board[list[0]] != 0 &&
          board[list[0]] == board[list[1]] &&
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }

    if (isMovesLeft(board)) {
      return 3;
    }
    return 0;
  }

  static bool isMovesLeft(List<int> board) {
    for (var val in board) {
      if (val == 0) return false;
    }
    return true;
  }

  static String getSymbol(
      int index, PlayerSymbolEnum? playerOne, PlayerSymbolEnum? playerTwo) {
    if (index == 1) {
      return playerOne!.toShortString();
    } else if (index == 2) {
      return playerTwo!.toShortString();
    } else
      return "";
  }

  static Color getTileColor(String symbol) {
    if (symbol == "X")
      return Colors.red;
    else
      return Colors.black;
  }

  static showGameEndDialog(
      BuildContext context, GamePageState state, Function restart) {
    String titleText;
    if (state is GameWinState) {
      titleText = state.activePlayer.symbol!.toShortString()+AppStrings.win_desc_text;
    } else {
      titleText = AppStrings.draw_desc_text;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alertDialog(context, state, restart, titleText);
        });
  }

  static Widget alertDialog(BuildContext context, GamePageState state,
      Function restart, String titleText) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColorDark,
      title: Center(
          child: Text(
        titleText, style: TextStyle(color: Theme.of(context).primaryColorLight),
        textDirection: TextDirection.ltr,
      )),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              restart();
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight)),
            child: Text(AppStrings.restart_cta_text,
                style: TextStyle(color: Theme.of(context).primaryColorDark))),
      ],
    );
  }

  static showRulesDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Center(
              child: Text(
                AppStrings.rules_title_text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight),
              ),
            ),
            content: Text(
              AppStrings.rules_desc_text,
              style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColorLight),
            ),
          );
        });
  }

  static int flipPlayer(int currentPlayerNumber) {
    if (currentPlayerNumber == 1)
      return 2;
    else
      return 1;
  }

  static bool isMoveLegal(List<int> board, int move) {
    if (move < 0 || move >= board.length || board[move] != 0) return false;
    return true;
  }
}
