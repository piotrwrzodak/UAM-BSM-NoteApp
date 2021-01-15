import 'package:bsm_noteapp/services/state.dart';
//import 'package:bsm_noteapp/services/bioAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChooseLogin extends StatefulWidget {
  @override
  _ChooseLoginState createState() => _ChooseLoginState();
}

class _ChooseLoginState extends State<ChooseLogin> {
  
  //final BioAuth auth = BioAuth();

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
                _buildChangeLogin(),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeLogin() {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
           RaisedButton(
                color: Colors.yellow,
                child: Text('LOGIN WITH PASSWORD'),
                onPressed: () {
                var authStatus = context.read<AuthStatus>();
                authStatus.setLoginMethod("password");
                },
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('LOGIN WITH FINGERPRINT'),
                onPressed: () {
                var authStatus = context.read<AuthStatus>();
                authStatus.setLoginMethod("fingerprint");
                },
              ),
        ]
      )
    );
  }
}

