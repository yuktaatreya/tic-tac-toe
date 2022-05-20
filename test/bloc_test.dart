
import 'package:bloc_test/bloc_test.dart';
import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/bloc/game_page_bloc.dart';
import 'package:example_app/screens/game_page/bloc/game_page_events.dart';
import 'package:example_app/screens/game_page/bloc/game_page_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  group('GamePageBloc', () {
    List<int> board = List.generate(9, (int index) => 0);
    Player playerOne =Player(number: 1,playerType: PlayerTypeEnum.HUMAN);
    Player playerTwo =Player(number: 2,playerType: PlayerTypeEnum.AI);

    blocTest<GamePageBloc,GamePageState>(
      'emits [] when nothing is added',
      build: () => GamePageBloc(InitState(playerOne,board)),
      expect: () => [],
    );

    blocTest<GamePageBloc,GamePageState>(
      'emits NextMoveState on Human play',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(TilePress(
        index: 0,
          board: board,
          currentPlayer: playerOne, playerOne: playerOne,
          playerTwo: playerTwo)),
      expect: () => [NextMoveState(playerTwo, [1,0,0,0,0,0,0,0,0])],
    );


    blocTest<GamePageBloc,GamePageState>(
      'emits NextMoveState on Ai play',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(TilePress(
          board:[1,0,0,0,0,0,0,0,0],
          currentPlayer: playerTwo, playerOne: playerOne,
          playerTwo: playerTwo)),
      expect: () => [NextMoveState(playerOne, [1,2,0,0,0,0,0,0,0])],
    );

    blocTest<GamePageBloc,GamePageState>(
      'emits Draw state when board is full',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(TilePress(
          board:[2, 1, 2, 1, 2, 1, 1, 2, 0],
          currentPlayer: playerTwo, playerOne: playerOne,
          playerTwo: playerTwo)),
      expect: () => [GameDrawState([2, 1, 2, 1, 2, 1, 1, 2, 1])],
    );

    blocTest<GamePageBloc,GamePageState>(
      'emits win state, human winner',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(TilePress(
        index: 8,
          board:[1, 2, 1, 2, 2, 1, 0, 0, 0],
          currentPlayer: playerOne, playerOne: playerOne,
          playerTwo: playerTwo)),
      expect: () => [GameWinState(playerOne,[1, 2, 1, 2, 2, 1, 0, 0, 1])],
    );
    blocTest<GamePageBloc,GamePageState>(
      'emits win state, ai winner',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(TilePress(
          board:[2, 2, 0, 0, 1, 0, 0, 1, 1],
          currentPlayer: playerTwo, playerOne: playerOne,
          playerTwo: playerTwo)),
      expect: () => [GameWinState(playerTwo,[2, 2, 2, 0, 1, 0, 0, 1, 1])],
    );

    blocTest<GamePageBloc,GamePageState>(
      'emits init state on restart',
      build: () => GamePageBloc(InitState(playerOne,board)),
      act: (bloc) => bloc.add(RestartGame(playerOne)),
      expect: () => [InitState(playerOne,[0,0,0,0,0,0,0,0,0])],
    );
  });
}