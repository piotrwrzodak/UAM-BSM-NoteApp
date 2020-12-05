import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
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
}