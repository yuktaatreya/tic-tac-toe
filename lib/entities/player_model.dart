import 'package:equatable/equatable.dart';
import 'package:example_app/entities/player_symbol_enum.dart';
import 'package:example_app/entities/player_type_enum.dart';

class Player extends Equatable{
  late PlayerTypeEnum? playerType;
  late int number;
  late PlayerSymbolEnum? symbol;
  Player({required this.number,this.playerType,this.symbol});


  @override
  List<Object?> get props => [playerType,number,symbol];

}