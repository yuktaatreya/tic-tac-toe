// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_symbol_enum.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/game_page.dart';
import 'package:example_app/screens/home_page/home_page.dart';
import 'package:example_app/screens/widgets/game_tile/game_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example_app/main.dart';

void main() {
  testWidgets('game tile widget', (WidgetTester tester) async {
    await tester.pumpWidget(GameTile(onTap: (int id)=>print(id), text: "Test", id: 1));
    final titleFinder = find.text('Test');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('home page widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    final titleFinder = find.text('Play');
    expect(titleFinder, findsWidgets);
  });
  testWidgets('game page widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GamePage(
      playerOne: Player(number: 1,symbol: PlayerSymbolEnum.X,playerType: PlayerTypeEnum.HUMAN),
      playerTwo: Player(number: 2,symbol: PlayerSymbolEnum.O,playerType: PlayerTypeEnum.AI),
    )));
    final titleFinder = find.text('');
    expect(titleFinder, findsNWidgets(9));
  });

}
