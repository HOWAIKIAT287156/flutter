import 'package:bookbytes/UserHandling.dart/ForgotPass.dart';
import 'package:flutter/material.dart';
import 'UserRegis.dart'; 


class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.blueGrey), // Set the color of the text
        ),
        backgroundColor: Color.fromRGBO(200, 242, 255, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username TextField
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Password TextField
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                },
                child: Text('Login'),
              ),

              SizedBox(height: 16),

              // Row for "Forgot password" and "Don't have an account?"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserRegistrationPage()), // Navigate to UserRegis.dart
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(fontSize: 13),
                    ),
                    child: Text("Don't have an account?"),
                  ),
                  
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()), // Navigate to ForgotPass.dart
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(fontSize: 13),
                    ),
                    child: Text('Forgot password?'),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserLoginPage(),
  ));
}




