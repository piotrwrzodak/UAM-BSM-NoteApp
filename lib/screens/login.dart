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
  
  final TextEditingController _repeatedPasswordController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _loginPasswordController = new TextEditingController();

  String message = "";

  final Authenticate auth = Authenticate();
  
  FormType _form = FormType.login; 

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
                _buildOutput(),
                _buildButtons(),
                
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
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new TextField(
                controller: _loginPasswordController,
                decoration: new InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children:[
               TextField(
                controller: _passwordController,
                decoration: new InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              TextField(
                controller: _repeatedPasswordController,
                decoration: new InputDecoration(
                  hintText: 'Repeat password',
                ),
                obscureText: true,
              ),
          ],
        ),
      );
    }
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
                onPressed: () async {
                  //print('user wants to login with: ' + '\''+ _loginPasswordController.text + '\'');
                  final output = await auth.login(_loginPasswordController.text);
                  if (output) {
                    var authStatus = context.read<AuthStatus>();
                    final hash = auth.setHash(_loginPasswordController.text);
                    authStatus.string = hash;
                    authStatus.toggle();
                  } 
                  else {
                    setState(() => message = "Incorect password.");
                  }
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
              onPressed: () {
                _formChange();
                setState(() => message = "");
              },
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
                onPressed: () async {
                  print('user wants to register with: ' + '\''+ _passwordController.text + '\'');
                  final output = await auth.register(_passwordController.text, _repeatedPasswordController.text);
                  if (output == "Registered succesfully!") {
                    var authStatus = context.read<AuthStatus>();
                    final hash = auth.setHash(_passwordController.text);
                    authStatus.string = hash;
                    authStatus.toggle();
                  }
                  setState(() => message = output);
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
              onPressed: () {
                _formChange();
                setState(() => message = "");
                },
            )
          ],
        ),
      );
    }
  }
}