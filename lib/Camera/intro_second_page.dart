import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotobudka/Camera/intro_first_page.dart';

class SecondIntroDialog extends StatefulWidget {
  SecondIntroDialog({Key? key}) : super(key: key);

  String title = "Jak działa aplikacja?";
  String descriptions = "Użytkowanie aplikacji jest bajecznie proste! Wystarczy nacisnąć środkowy przycisk u dołu ekranu aby rozpocząć nową serię zdjęć!\n\nPo wykonaniu całej serii odpowiedni plik zostanie zapisany na serwerze i będzie gotowy do wydruku na kartcę o formacie A4\n\nAby przejść do konfiguracji wystarczy kliknąć ikonkę koła zębatego u dołu ekraniu i wybrać interesujące nas parametry!";
  String text = "Pomiń";
  String text1 = "Wstecz";

  @override
  _SecondIntroDialogState createState() => _SecondIntroDialogState();
}

class _SecondIntroDialogState extends State<SecondIntroDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,top: 65, right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FirstIntroDialog();
                            },
                          );
                        },
                        child: Text(widget.text1,style: TextStyle(fontSize: 18),)),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.text,style: TextStyle(fontSize: 18),)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image.asset("assets/thinking.png")
            ),
          ),
        ),
      ],
    );
  }
}