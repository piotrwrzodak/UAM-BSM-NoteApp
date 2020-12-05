import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _repeatPasswordController = new TextEditingController();
  final TextEditingController _newPasswordController = new TextEditingController();

  String _password = "";
  String _repeatPassword = "";
  String _newPassword = "";
  
  _SettingsState() {
    _passwordController.addListener(_passwordListen);
    _repeatPasswordController.addListener(_repeatPasswordListen);
    _newPasswordController.addListener(_newPasswordListen);
  }

  void _passwordListen() {
    if (_passwordController.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordController.text;
    }
  }
  void _repeatPasswordListen() {
    if (_repeatPasswordController.text.isEmpty) {
      _repeatPassword = "";
    } else {
      _repeatPassword = _repeatPasswordController.text;
    }
  }
  void _newPasswordListen() {
    if (_newPasswordController.text.isEmpty) {
      _newPassword = "";
    } else {
      _newPassword = _newPasswordController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
       body: Center(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.headline1,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                TextFormField(
                  controller: _repeatPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Repeat password',
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    hintText: 'New password',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text('SAVE'),
                  onPressed: () {
                    _savePressed();
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

   void _savePressed () {
    print('The user wants to change password from $_password to $_newPassword');
  }

}