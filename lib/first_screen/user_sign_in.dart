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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  String password;
  var uname;
  var upass;
  var userDatalist;
  @override
  initState() {
    super.initState();
    getUpdates();
  }

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyThemeData.themeData.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  _userName(),
                  _userPassword(),
                  _loginButton(),
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
      ),
    );
  }

  Widget _userName() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onChanged: (text) {
          if (text.isEmpty) {
            name = "";
          } else {
            name = text;
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          hintText: "User Name",
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (text) => (text.isEmpty)
            ? "Field cannot be empty "
            : (text.length < 4)
                ? "Username is too short"
                : (!checkUserName(name))
                    ? "Username does not match"
                    : null,
      ),
    );
  }

  Widget _userPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: TextFormField(
        onChanged: (text) {
          if (text.isEmpty) {
            password = "";
          } else {
            password = text;
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          hintText: "Password",
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (text) => (text.isEmpty)
            ? "Field cannot be empty "
            : (text.length < 5)
                ? "Password should be atleast 6 characters"
                : (!checkUserPassword(password))
                    ? "Password does not match"
                    : null,
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Builder(
        builder: (BuildContext context) {
          return new InkWell(
              onTap: () {
                //final form = _formKey.currentState.validate();
                FocusScope.of(context).unfocus();
                if ((_formKey.currentState.validate())) {
                  print("Saved Form");
                  if (checkNamePassword(name, password)) {
                    print("Login Successful");
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      backgroundColor: Colors.white,
                      content: Text('Login Successful',
                          style: TextStyle(color: Colors.black)),
                      duration: Duration(seconds: 3),
                    ));
                    Timer(Duration(seconds: 2), () {
                      Navigator.of(context).pushNamed(UserDocuments.routeName);
                    });
                  }
                } else {
                  print("Not saved!");
                  print("Login UnSuccessful! User's Info doesn't exist");
                  Scaffold.of(context).showSnackBar((new SnackBar(
                    backgroundColor: Colors.white,
                    content: Text('Login UnSuccessful',
                        style: TextStyle(color: Colors.black)),
                    duration: Duration(seconds: 3),
                  )));
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
    );
  }

  getUpdates() async {
    print('accessible');
    var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/users');
    try {
      http.Response response = await http.get(apiUrl);
      print("Print $response");

      if (response.statusCode == 200) {
        userDatalist = json.decode(response.body);
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool checkUserName(String name) {
    for (var user in userDatalist) {
      String uname = user['username'];
      if (name.toLowerCase().trim() == uname.toLowerCase().trim()) {
        return true;
      }
    }
    return false;
  }

  bool checkUserPassword(String password) {
    for (var user in userDatalist) {
      String upass = user['email'];
      if (password.toLowerCase().trim() == upass.toLowerCase().trim()) {
        return true;
      }
    }
    return false;
  }

  bool checkNamePassword(String name, String password) {
    for (var user in userDatalist) {
      String uname = user['username'];
      String upass = user['email'];
      if (name.toLowerCase().trim() == uname.toLowerCase().trim() &&
          password.toLowerCase().trim() == upass.toLowerCase().trim()) {
        return true;
      }
    }
    return false;
  }
}
