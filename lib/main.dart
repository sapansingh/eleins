import 'package:eleins/geoloca.dart';
import 'package:eleins/home.dart';
import 'package:eleins/login.dart';
import 'package:eleins/mainpage/servy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(Home());
}
class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> { 
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body:LoginPage()),);
 //   return MaterialApp(home: status ? home():LoginPage());
  }

}