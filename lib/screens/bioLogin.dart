import 'package:bsm_noteapp/services/auth.dart';
import 'package:bsm_noteapp/services/bioAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BioLogin extends StatefulWidget {
  @override
  _BioLoginState createState() => _BioLoginState();
}

class _BioLoginState extends State<BioLogin> {
  
  final BioAuth auth = BioAuth();

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
                  bool bioLoginStatus = await auth.checkBio();
                  if (bioLoginStatus) await auth.prepareKeys();
                  var authStatus = context.read<AuthStatus>();
                  if (bioLoginStatus) authStatus.toggle();
                },
              ),
              // // button to reset all data
              // RaisedButton(
              //   color: Colors.yellow,
              //   child: Text('RESET ALL'),
              //   onPressed: () async {
              //       await auth.clear();
              //     } 
              // ),
        ]
      )
    );
  }
}