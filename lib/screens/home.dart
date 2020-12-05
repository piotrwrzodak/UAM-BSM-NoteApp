import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNote extends StatefulWidget {
  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App', style: Theme.of(context).textTheme.headline1),
      ),
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