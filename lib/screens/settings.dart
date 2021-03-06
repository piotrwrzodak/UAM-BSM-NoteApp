import 'package:bsm_noteapp/services/auth.dart';
import 'package:bsm_noteapp/services/changePassword.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ChangePassword change = ChangePassword();
  final Authenticate auth = Authenticate();

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _repeatPasswordController = new TextEditingController();
  final TextEditingController _newPasswordController = new TextEditingController();

  String message = "";

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
                  obscureText: true,
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
                _buildOutput(),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text('SAVE'),
                  onPressed: () async {
                    String output = await change.changePassword(_passwordController.text, _repeatPasswordController.text, _newPasswordController.text);
                    setState(() {
                      message = output;
                    });
                    FocusScope.of(context).unfocus();
                    if (output == "Password succesfully changed!") {
                      var authStatus = context.read<AuthStatus>();
                      final hash = auth.setHash(_newPasswordController.text);
                      authStatus.string = hash;
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutput() {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[800])
          ),
      ])
    );
  }
}