
import 'dart:convert';

import 'package:eleins/apiurl.dart';
import 'package:eleins/home.dart';
import 'package:eleins/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(),
          Center(
            child:AnimatedLoginForm() ,
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      color: Colors.blue,
      child: ClipPath(
        clipper: CurveClipper(),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.6, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AnimatedLoginForm extends StatefulWidget {
  @override
  _AnimatedLoginFormState createState() => _AnimatedLoginFormState();
}

class _AnimatedLoginFormState extends State<AnimatedLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isClicked = false;

    bool? status;
  String? stateid;
  String? userid;
   String? cityid;
    String? consitituencyno;
     bool? contactinfo;



    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Image.asset("assets/logo-big.png"))
                ,TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                   
                      // Perform login logic here
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                    
            
            
            
            _submitlogin();
            
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _isClicked ? 150.0 : 200.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: _isClicked ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 3.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isClicked
                          ? Icon(Icons.check, color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _submitlogin()async{
    String dat=api().apiserve;
 String host="$dat/login.php";

 print(host);
   var payload={
      'userid':_usernameController.text,
      'password':_passwordController.text
    
   };

    var jsonPayload = jsonEncode(payload);

      print(jsonPayload);
      // Send POST request
      var response = await http.post(
        Uri.parse('$host'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonPayload,
      );
if(response.statusCode==200){

Map<String,dynamic> rept=jsonDecode(response.body);

print(jsonDecode(response.body));
Future.delayed(Duration(seconds: 2));
if(rept['status']){
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool("status",rept!['status']);
await prefs.setString("userid",rept!['userid']);
await prefs.setString("stateid",rept['stateid']);
await prefs.setString("cityid",rept['cityid']);
await prefs.setString("consitituencyno",rept['consitituencyno']);
await prefs.setBool("contactinfo",rept['contactinfo']);
await prefs.setString("roll",rept['roll']);
await prefs.setString("pic",rept['pic']);


if(rept['status']){
if(rept['contactinfo']){
  print(rept['contactinfo']);

Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=>home()));
}else{
Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=>permission_handler()));
   setState(() {
                    _isClicked = !_isClicked;
                  });
}
}

}else{
          toastification.show(
  context: context,
   type: ToastificationType.error,
  style: ToastificationStyle.fillColored,
  title: Text('User not found!'),
  autoCloseDuration: const Duration(seconds: 3),
);
}

}else{

  print("api faild");
}

  }


  void getdata() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  status = prefs?.getBool('status');
  userid=prefs.getString("userid");
   stateid=prefs.getString("stateid");
  cityid=prefs.getString("cityid");
  consitituencyno=prefs.getString("consitituencyno");
   contactinfo=prefs.getBool("contactinfo");

print(userid);
  if(status!=null){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
setState(() {
 
});

  }


}



}
