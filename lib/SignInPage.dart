import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signin() async {
    var body = jsonEncode({
      "type": 0,
      "email": emailController.text,
      "password": passwordController.text,
    });
    var header = {
      'Content-Type': 'application/json',
      "Accept": 'application/json'
    };
    var response = await http.post(
      Uri.parse('https://babelmate-7541e8c182e6.herokuapp.com/auth/signin'),
      headers: header,
      body: body,
    );
    print(response.body);
    var data = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/blue.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            width: double.infinity,
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                  hintStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: 350,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                signin();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff73dcfc)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
