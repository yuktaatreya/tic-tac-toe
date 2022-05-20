import 'package:example_app/constants/app_colors.dart';
import 'package:example_app/constants/app_strings.dart';
import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/bloc/game_page_bloc.dart';
import 'package:example_app/screens/game_page/bloc/game_page_events.dart';
import 'package:example_app/screens/widgets/game_tile/game_tile.dart';
import 'package:example_app/utils/game_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/game_page_state.dart';

class GamePage extends StatefulWidget {
  final Player playerOne;
  final Player playerTwo;
  const GamePage({
    Key? key,
    required this.playerOne,
    required this.playerTwo,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GamePageBloc gamePageBloc;
  late Player _currentPlayer;
  List<int> board = List.generate(9, (int index) => 0);

  @override
  void initState() {
    _currentPlayer = widget.playerOne;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorOne,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorOne,
        title: Text(AppStrings.app_bar_title_text,
        style: TextStyle(color: AppColors.colorTwo),),
        actions: <Widget>[
          IconButton(onPressed: (){
            GameUtil.showRulesDialog(context);
          },
              icon: Icon(Icons.info_outline,color: AppColors.colorTwo,))
        ],
      ),
      body: Center(
        child: BlocProvider<GamePageBloc>(
          create: (context) {
            gamePageBloc = GamePageBloc(InitState(widget.playerOne, board));

            return gamePageBloc;
          },
          child: BlocConsumer<GamePageBloc, GamePageState>(
              listener: (context, state) {
            if (state is NextMoveState || state is InitState) {
              board = state.board;
              _currentPlayer = state.activePlayer;
              if(state.activePlayer.playerType==PlayerTypeEnum.AI && state is NextMoveState ) {
                gamePageBloc.add(TilePress(
                    board: board,
                    currentPlayer: _currentPlayer,
                    playerOne: widget.playerOne,
                    playerTwo: widget.playerTwo));
              }
            } else
              GameUtil.showGameEndDialog(context, state,
                  () => gamePageBloc.add(RestartGame(widget.playerOne)));
          }, builder: (context, state) {
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GameTile(
                    color: GameUtil.getTileColor(GameUtil.getSymbol(
                        state.board[index],
                        widget.playerOne.symbol,
                        widget.playerTwo.symbol)),
                    id: index,
                    text: GameUtil.getSymbol(state.board[index],
                        widget.playerOne.symbol, widget.playerTwo.symbol),
                    onTap: onTap,
                  );
                });
          }),
        ),
      ),
    );
  }

  void onTap(int index) {
    gamePageBloc.add(TilePress(
        index: index,
        board: board,
        currentPlayer: _currentPlayer,
        playerOne: widget.playerOne,
        playerTwo: widget.playerTwo));
  }
}
