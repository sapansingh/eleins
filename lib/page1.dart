import 'package:flutter/material.dart';



class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(child: Scaffold(appBar: AppBar(title:Text("ELEINS"),backgroundColor:Colors.amber,),drawer: Drawer(),),);
  }
}



