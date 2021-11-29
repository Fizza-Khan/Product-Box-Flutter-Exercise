import 'package:check/second_screen/user_documents.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Resources/AllColors.dart';
import 'dart:async';

class UserSignIn extends StatefulWidget {
  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  String name;
  String password;
  var uname;
  var upass;
  var userDatalist;
  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyThemeData.themeData.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25.0),
                Text(
                  "Log In",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20.0),
                TextField(
                    onChanged: (text) {
                      if (text.isEmpty) {
                        name = "";
                      } else {
                        name = text;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      hintText: "User Name",
                      filled: true,
                      fillColor: Colors.white,
                    )),
                SizedBox(height: 20.0),
                TextField(
                    onChanged: (text) {
                      if (text.isEmpty) {
                        password = "";
                      } else {
                        password = text;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                    )),
                SizedBox(height: 20.0),
                Builder(
                  builder: (BuildContext context) {
                    return new InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          getUpdates();
                          if (name == null || password == null) {
                            print("Text Field Empty");
                          } else {
                            if (checkAuth(name, password, userDatalist)) {
                              print("Login Successful");
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                backgroundColor: Colors.white,
                                content: Text('Login Successful',
                                    style: TextStyle(color: Colors.black)),
                                duration: Duration(seconds: 3),
                              ));
                              Timer(Duration(seconds: 3), () {
                                Navigator.of(context)
                                    .pushNamed(UserDocuments.routeName);
                              });
                            } else {
                              print("Login UnSuccessful");
                              Scaffold.of(context).showSnackBar((new SnackBar(
                                backgroundColor: Colors.white,
                                content: Text('Login UnSuccessful',
                                    style: TextStyle(color: Colors.black)),
                                duration: Duration(seconds: 3),
                              )));
                            }
                          }
                        },
                        child: new Container(
                            height: 49.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: MyThemeData.themeData.primaryColor,
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.indigo),
                ),
                SizedBox(height: 35.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Register Here',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

  getUpdates() async {
    print('accessible');
    var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(apiUrl);
    print("Print $response");

    if (response.statusCode == 200) {
      userDatalist = json.decode(response.body);
    }
    return json.decode(response.body);
  }

  bool checkAuth(String name, String password, var userDatalist) {
    for (var user in userDatalist) {
      String uname = user['username'];
      String upass = user['email'];
      if (name == uname && password == upass) {
        return true;
      }
    }
    return false;
  }
}
