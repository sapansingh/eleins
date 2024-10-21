import 'dart:convert';

import 'package:eleins/apiurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class totalcound{
  String? totalcount;

totalcound({this.totalcount});

factory totalcound.fromJson(Map<String,dynamic> json){

  return totalcound(totalcount: json['totalcount']);
}
}

class TotalServ extends StatefulWidget {
  const TotalServ({super.key});

  @override
  State<TotalServ> createState() => _TotalServState();
}

class _TotalServState extends State<TotalServ> {

String host=api().apiserve;
  String? userid;
  String totalc="";

    void getdata() async{

    Future.delayed(Duration(seconds: 2));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userid=prefs.getString("userid");
 
    _getcount();
   print(userid);
    }

    @override
    void initState() {
      super.initState();
      getdata();
     
    }

_getcount()async{

      final response = await http.post(
    Uri.parse('$host/api/totalservy.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'userid':userid,
    }),
  );
 
if(response.statusCode==200){

  Map<String,dynamic> count=jsonDecode(response.body);

    totalc=count['totalcount'];
    setState(() {
       print(totalc);
    });
}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body:Center(child: Column(
      children: [Text('Total Count',style: TextStyle(fontSize: 50,fontWeight: FontWeight.w500,color: Colors.green),),
        Text(totalc,style: TextStyle(fontSize: 150,color:Colors.amber,fontWeight: FontWeight.w700)),
      ],
    ) ));
  }
}


