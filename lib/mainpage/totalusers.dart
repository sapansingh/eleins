import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// User model class
class User {
  final String userid;
  final String username;

  User({required this.userid, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'], // Ensure these keys match your actual JSON response
      username: json['username'],
    );
  }
}

// Fetch users from an API
Future<List<User>> fetchUsers() async {
  const url = 'https://aims-doc.com/eleins/api/totalusers.php'; // Example API URL
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List<dynamic> userJson = json.decode(response.body);
    return userJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

// Main application widget
class TotalUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
        ),
        body: UsersList(),
      );
    
  }
}

// Widget to display list of users
class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          // Data is fetched successfully, let's display it
          List<User> users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].username),
                subtitle: Text('User ID: ${users[index].userid}'),
              );
            },
          );
        }
      },
    );
  }
}
