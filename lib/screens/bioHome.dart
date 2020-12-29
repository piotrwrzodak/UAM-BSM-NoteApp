import 'package:bsm_noteapp/services/auth.dart';
import 'package:bsm_noteapp/services/bioAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBioNote extends StatefulWidget {
  @override
  _MyBioNoteState createState() => _MyBioNoteState();
}

class _MyBioNoteState extends State<MyBioNote> {

  final TextEditingController _noteController = new TextEditingController();
  BioAuth _bioAuth = BioAuth();


  @override
  void initState() {
    (() async {
      _noteController.text = await _bioAuth.getNote();
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
          icon: Icon(Icons.logout), 
          onPressed: () {
            var authStatus = context.read<AuthStatus>();
            //authStatus.string = "";
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
                  onPressed: () async {
                    await _bioAuth.saveNote(_noteController.text);
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
