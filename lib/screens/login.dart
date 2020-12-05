import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FormType {
  login,
  register
}

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  
  final TextEditingController _passwordFilter = new TextEditingController();
  String _password = "";
  FormType _form = FormType.login; 
  
  _MyLoginState() {
    _passwordFilter.addListener(_passwordListen);
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextFields(),
                _buildButtons(),
                Consumer<AuthStatus>(
                builder: (context, authStatus, child) => Text(
                  '${authStatus.loggedIn}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var authStatus = context.read<AuthStatus>();
          authStatus.toggle();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('LOGIN'),
                onPressed: () {
                  var authStatus = context.read<AuthStatus>();
                  authStatus.toggle();
                  _loginPressed();
                },
              ),
            FlatButton(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Dont have an account?\n Tap here to register.',
                   textAlign: TextAlign.center
                   ),
              ),
              onPressed: _formChange,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('REGISTER'),
                onPressed: () {
                  var authStatus = context.read<AuthStatus>();
                  authStatus.toggle();
                  _createAccountPressed();
                },
              ),
            new FlatButton(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Have an account?\n Click here to login.',
                   textAlign: TextAlign.center
                   ),
              ),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  void _loginPressed () {
    print('The user wants to login with $_password');
  }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_password');
  }

}