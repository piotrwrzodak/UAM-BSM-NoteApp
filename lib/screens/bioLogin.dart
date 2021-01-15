import 'package:bsm_noteapp/services/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BioLogin extends StatefulWidget {
  @override
  _BioLoginState createState() => _BioLoginState();
}

class _BioLoginState extends State<BioLogin> {

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
                _buildLogin(),
                _buildChangeLogin(),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
           RaisedButton(
                color: Colors.yellow,
                child: Text('LOGIN'),
                onPressed: () async {
                  
                },
              ),
        ]
      )
    );
  }

  Widget _buildChangeLogin() {
    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
           new FlatButton(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'login with password',
                   textAlign: TextAlign.center
                   ),
              ),
              onPressed: () {
                var authStatus = context.read<AuthStatus>();
                authStatus.setLoginMethod("password");
                },
            )
        ]
      )
    );
  }
}