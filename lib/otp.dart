import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP extends StatefulWidget {
  final String email;
  final String password;
  final String username;
  final String first_name;
  final String last_name;
  final int otp;

  const OTP(
      {super.key,
      required this.email,
      required this.password,
      required this.username,
      required this.first_name,
      required this.last_name,
      required this.otp});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Verify your number",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "please enter 6-digit code sent to ${widget.email} ",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(40),
                  fieldHeight: 50,
                  fieldWidth: 40),
              keyboardType: TextInputType.number,
              onChanged: (Value) {},
              onCompleted: (value) async {
                //print(widget.otp);
                if (int.parse(value) == widget.otp) {
                  EasyLoading.show();
                  await signUp();
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("OTP Dont MAtch")));
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "you can request a new code in 17 seconds",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> signUp() async {
    var body = jsonEncode({
      "email": widget.email,
      "password": widget.password,
      "username": widget.username,
      "first_name": widget.first_name,
      "last_name": widget.last_name,
      "age": 18,
      "user_languages": ["urdu", "punjabi"],
      "exchange_languages": ["french", "english"],
      "interests": ["tech", "swimming"]
    });
    var header = {
      'Content-Type': 'application/json',
      "Accept": 'application/json'
    };
    var response = await http.post(
        Uri.parse("https://babelmate-7541e8c182e6.herokuapp.com/auth/signup"),
        headers: header,
        body: body);
    print(response.body);
    var data = jsonDecode(response.body);
    if (data["code"] == "0") {
      EasyLoading.showSuccess("User created");
      EasyLoading.dismiss();
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(data["message"])));
    } else {
      EasyLoading.showError(data["message"]);
      EasyLoading.dismiss();
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(data["message"])));
    }
  }
}
