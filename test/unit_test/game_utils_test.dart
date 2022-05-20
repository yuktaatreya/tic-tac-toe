import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_symbol_enum.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/bloc/game_page_bloc.dart';
import 'package:example_app/screens/game_page/bloc/game_page_state.dart';
import 'package:example_app/utils/game_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:test/test.dart';

void main() {
  group('unit test test for evaluateBoard method', (){
    test('win case for player one', (){
      List<List<int>> winningMoves=[
        [1, 2, 2, 0, 1, 0, 0, 0, 1],
        [1, 1, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 1, 1],
        [2, 2, 1, 0, 1, 0, 1, 0, 0],
        [1, 2, 2, 1, 0, 0, 1, 0, 0],
        [2, 1, 2, 0, 1, 0, 0, 1, 0],
        [2, 2, 1, 0, 0, 1, 0, 0, 1]
      ];
      List<int> playerOne=[];
      for (List<int> list in winningMoves){
        playerOne.add(GameUtil.evaluateBoard(list));
      }
      expect(playerOne, [1,1,1,1,1,1,1,1]);
    });

    test('win case for player 2 ', (){
      List<List<int>> winningMoves=[
        [2, 0, 0, 0, 2, 0, 0, 0, 2],
        [2, 2, 2, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 2, 2, 2, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 2, 2, 2],
        [0, 1, 2, 0, 2, 0, 2, 0, 0],
        [2, 1, 0, 2, 0, 0, 2, 0, 0],
        [0, 2, 0, 0, 2, 0, 0, 2, 0],
        [0, 0, 2, 0, 0, 2, 0, 0, 2]
      ];
      List<int> playerOne=[];
      for (List<int> list in winningMoves){
        playerOne.add(GameUtil.evaluateBoard(list));
      }
      expect(playerOne, [2,2,2,2,2,2,2,2]);
    });

    test('draw case', (){
      int draw = GameUtil.evaluateBoard([2, 1, 2, 1, 2, 1, 1, 2, 1]);
      expect(draw, 3);
    });

    test('no winners yet case', (){
      int draw = GameUtil.evaluateBoard([1,2,0,0,0,0,0,0,0]);
      expect(draw, 0);
    });

  } );

  test('unit test for isBoardFull method', (){
    bool isBoardFull = GameUtil.isMovesLeft([2, 1, 2, 1, 2, 1, 1, 2, 1]);
    expect(isBoardFull, true);
    isBoardFull = GameUtil.isMovesLeft([1,2,0,0,0,0,0,0,0]);
    expect(isBoardFull, false);
  });

  test('unit test for getSymbol method', (){
    String playerSymbol=GameUtil.getSymbol(1, PlayerSymbolEnum.X,PlayerSymbolEnum.O);
    expect(playerSymbol, "X");

    playerSymbol=GameUtil.getSymbol(1, PlayerSymbolEnum.O,PlayerSymbolEnum.X);
    expect(playerSymbol, "O");

    playerSymbol=GameUtil.getSymbol(2, PlayerSymbolEnum.X,PlayerSymbolEnum.O);
    expect(playerSymbol, "O");

    playerSymbol=GameUtil.getSymbol(2, PlayerSymbolEnum.O,PlayerSymbolEnum.X);
    expect(playerSymbol, "X");

    playerSymbol=GameUtil.getSymbol(0, PlayerSymbolEnum.O,PlayerSymbolEnum.X);
    expect(playerSymbol, "");

  });

  test('unit test for getTileColor method', (){
    Color tileColor=GameUtil.getTileColor("X");
    expect(tileColor, Colors.red);

    tileColor=GameUtil.getTileColor("O");
    expect(tileColor, Colors.black);
  });

  test('unit test for flipCurrentPlayer method', (){
    int player = GameUtil.flipPlayer(Player(number: 1).number);
    expect(player, Player(number: 2).number);

    player=GameUtil.flipPlayer(Player(number: 2).number);
    expect(player, Player(number: 1).number);
  });

  test('unit test isMoveLegal method', (){
    bool isMoveLegal = GameUtil.isMoveLegal([1,0,0,0,0,0,0,0,0], 1);
    expect(isMoveLegal, true);

    isMoveLegal = GameUtil.isMoveLegal([1,0,0,0,0,0,0,0,0], 0);
    expect(isMoveLegal, false);
  });

  flutter_test.testWidgets('test game end dialog', (flutter_test.WidgetTester tester) async {
    List<int> board = List.generate(9, (int index) => 0);
    Player playerOne =Player(number: 1,symbol:PlayerSymbolEnum.X,playerType: PlayerTypeEnum.HUMAN);
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            home: GameUtil.alertDialog(context,
                GamePageBloc(GameWinState(playerOne,board)).state ,
                    ()=>print('testing'),'test'),
          );
        },
      ),
    );
    final titleFinder = flutter_test.find.text('test');
    expect(titleFinder, flutter_test.findsWidgets);
  });


}