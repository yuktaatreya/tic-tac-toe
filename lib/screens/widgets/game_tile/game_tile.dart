
import 'package:example_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
class GameTile extends StatelessWidget {
  final int id;
  final Function (int id)? onTap;
  final String text;
  final Color? color;
  const GameTile({Key? key,required this.text,this.color,this.onTap,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          if(text==''){
            onTap!(id);
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
            child: Container(
                child: Center(
                  child: Text(text,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontWeight: FontWeight.normal,fontSize: 28,color: AppColors.colorOne),
                  ),
                ),
                decoration: new BoxDecoration(
                    color: AppColors.colorTwo,
                    shape: BoxShape.rectangle,
                    border: Border.all(color:Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5))))));;
  }
}

