import 'package:example_app/constants/app_colors.dart';
import 'package:example_app/constants/app_strings.dart';
import 'package:example_app/constants/asset_paths.dart';
import 'package:example_app/entities/player_model.dart';
import 'package:example_app/entities/player_type_enum.dart';
import 'package:example_app/screens/game_page/game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../entities/player_symbol_enum.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMultiPlayer=false;
  bool isX=true;
  Player playerOne =Player(number: 1,playerType: PlayerTypeEnum.HUMAN);
  Player playerTwo = Player(number: 2);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppStrings.pick_side_desc_text,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 36,
                    color:Theme.of(context).primaryColorLight),),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isX=true;
                    });
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: isX?Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AssetPaths.x_icon,
                        color: isX?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorLight,
                          fit: BoxFit.contain,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isX=false;
                    });
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: isX?Theme.of(context).primaryColorDark:Theme.of(context).primaryColorLight
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AssetPaths.o_icon,
                          color: isX?Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark),
                      ))),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColorLight)
                ),
                  onPressed:(){
                    if(isX){
                      playerOne.symbol=PlayerSymbolEnum.X;
                      playerTwo.symbol=PlayerSymbolEnum.O;
                    }
                    else {
                      playerOne.symbol=PlayerSymbolEnum.O;
                      playerTwo.symbol=PlayerSymbolEnum.X;
                    }
                    if(isMultiPlayer){
                      playerTwo.playerType=PlayerTypeEnum.HUMAN;
                    }
                    else{
                      playerTwo.playerType=PlayerTypeEnum.AI;
                    }
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context)=>
                          GamePage(playerOne: playerOne,playerTwo: playerTwo)));
                  },
                  child: Text(AppStrings.play_cta_text,textDirection: TextDirection.ltr,
                  style: TextStyle(color: Theme.of(context).primaryColorDark,fontSize: 20,fontWeight: FontWeight.bold),))

            ],
          ),
        ),
      );
  }
}
