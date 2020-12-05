import 'package:bsm_noteapp/screens/settings.dart';
import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNote extends StatefulWidget {
  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {

  final TextEditingController _noteFilter = new TextEditingController();
  String _note = "";
 
  _MyNoteState() {
    _noteFilter.addListener(_noteListen);
  }

  void _noteListen() {
    if (_noteFilter.text.isEmpty) {
      _note = "";
    } else {
      _note = _noteFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App', style: Theme.of(context).textTheme.headline1),
        actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
            FocusScope.of(context).unfocus();
          },
        ),
        
        IconButton(
          icon: Icon(Icons.logout), 
          onPressed: () {
            var authStatus = context.read<AuthStatus>();
          authStatus.toggle();
          }
        )
      ],
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  maxLines: 3,
                  controller: _noteFilter,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  )
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
                  },
                ),
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

  void _savePressed () {
    print('The user saved $_note');
  }
}

