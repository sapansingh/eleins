
import 'package:flutter/material.dart';



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(),
          Center(
            child: AnimatedLoginForm(),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text("ELEINS",style: TextStyle(fontSize:50,color:Colors.amber)),),
            TextFormField(
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
                  setState(() {
                    _isClicked = !_isClicked;
                  });
                  // Perform login logic here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  print('Username: $username');
                  print('Password: $password');
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
    );
  }
}
