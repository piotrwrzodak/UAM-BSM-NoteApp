import 'package:bsm_noteapp/screens/settings.dart';
import 'package:bsm_noteapp/services/state.dart';
import 'package:bsm_noteapp/services/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNote extends StatefulWidget {
  @override
  _MyNoteState createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {

  final TextEditingController _noteController = new TextEditingController();
  final Note n = Note();

  @override
  void initState() {
    (() async {
      var authStatus = context.read<AuthStatus>();
      _noteController.text = await n.initNote(authStatus.string);
    })();
    super.initState();
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
            authStatus.string = "";
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
                  controller: _noteController,
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
                    var authStatus = context.read<AuthStatus>();
                    n.saveNote(_noteController.text, authStatus.string);
                    FocusScope.of(context).unfocus();
                  },
                ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
