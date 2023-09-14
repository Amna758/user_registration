import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:su/otp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameControlelr = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  //try{
  // Response rs = await post(
  //   Uri.parse('https://babelmate-7541e8c182e6.herokuapp.com/auth/signup'),
  //   body: {
  //     'email':Email,
  //     'password':Password,
  //     'first_name':First_name,
  //     'last_name'Last_name,
  //   }
  // );
  //   var response
  //   if(Response.statusCode==200){
  //     var data=jsonDecode(Response.body.toString());
  //    print(data);
  //     print('acc created');
  //   }
  //   else{
  //     print('failed');
  //   }
  // }
  // catch(e){
  //   print(e.toString());
  // }
  // }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            // SizedBox(
            //   height: 10,
            // ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                    hintText: 'User Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: 'first name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: lastNameControlelr,
                decoration: InputDecoration(
                    hintText: 'Last name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    hintStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await sendotp();
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
                  'Home Screen',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // void registered() async{
    //   var url('https://babelmate-7541e8c182e6.herokuapp.com/auth/signup');
    // }
  }

  Future<void> sendotp() async {
    var body = jsonEncode({
      "email": emailController.text,
    });
    var header = {
      'Content-Type': 'application/json',
      "Accept": 'application/json'
    };
    EasyLoading.show();
    var response = await http.post(
        Uri.parse(
          "https://babelmate-7541e8c182e6.herokuapp.com/auth/otp",
        ),
        headers: header,
        body: body);
    print(response.body);
    var data = jsonDecode(response.body);
    print(response.statusCode);
    var otp = data["otp"];
    EasyLoading.showSuccess("OTP Sent");
    EasyLoading.dismiss();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTP(
                  email: emailController.text,
                  password: passwordController.text,
                  username: userNameController.text,
                  first_name: firstNameController.text,
                  last_name: lastNameControlelr.text,
                  otp: otp,
                )));
  }
}
