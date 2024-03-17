import 'package:eleins/login.dart';
import 'package:eleins/mainpage/servy.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(Home());


}


class Home extends StatelessWidget {

  var isactive=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: isactive? LoginPage() : SurveyForm());
  }


  Material page(){
return Material(child: Center(child: CircularProgressIndicator(),),);
  }
}



