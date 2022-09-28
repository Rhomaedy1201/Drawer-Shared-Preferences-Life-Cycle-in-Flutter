import 'dart:convert';

import 'package:drawer_shared_life_sycle/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Screen_login extends StatefulWidget {
  @override
  State<Screen_login> createState() => _Screen_loginState();
}

class _Screen_loginState extends State<Screen_login> {
  bool _isObscure = true;
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString("login");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home_Screen()),
          (route) => false);
    }
  }

  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Text(
                          "HELLO",
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 185),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 167, 167, 167),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    height: 460,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 40,
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              fillColor: Colors.red,
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.purple,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 15,
                          ),
                          child: TextField(
                            controller: passController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.key_sharp,
                                color: Colors.purple,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: TextButton(
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 17),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.only(
                                  left: 70, right: 70, bottom: 15, top: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void login() async {
    if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({
            "email": emailController.text,
            "password": passController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // print("Login Token " + body["token"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token: ${body['token']}")));
        pageRoute(body['token']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credential")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank Value Found")));
    }
  }

  void pageRoute(String token) async {
    //menyimpan nilai token pada shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home_Screen()),
        (route) => false);
  }
}
