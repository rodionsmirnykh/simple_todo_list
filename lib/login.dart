import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:simple_todo_list/main_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = TextEditingController();

  final passwordController = TextEditingController();

  var isLogged = false;

  Future<void> checkLogin(String login, String pass) async {
    Map<String, dynamic> _loginData = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('logindata') ?? '';
    if (str.isNotEmpty) {
      _loginData = json.decode(prefs.getString('logindata') ?? '');
    }
    if (_loginData['login'] == login && _loginData['password'] == pass)
      isLogged = true;
    else
      isLogged = false;
    setState(() {});
  }

  void registration(String login, String pass) async {
    Map<String, dynamic> _loginData = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('logindata') ?? '';
    if (str.isNotEmpty) {
      _loginData = json.decode(prefs.getString('logindata') ?? '');
    }
    _loginData['login'] = login;
    _loginData['password'] = pass;
    prefs.setString('logindata', json.encode(_loginData));
    prefs.remove('tasks');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLogged == false
        ? Container(
            child: Column(
              children: [
                TextField(
                  controller: loginController,
                  decoration: InputDecoration(
                    hintText: 'Login',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  onSubmitted: (_) {
                    checkLogin(loginController.text, passwordController.text);
                  },
                ),
                TextButton(
                    onPressed: () {
                      registration(
                          loginController.text, passwordController.text);
                    },
                    child: Text('Registration'))
              ],
            ),
          )
        : MainPage();
  }
}
