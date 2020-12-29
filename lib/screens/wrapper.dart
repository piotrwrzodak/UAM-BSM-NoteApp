import 'package:bsm_noteapp/screens/bioHome.dart';
import 'package:bsm_noteapp/screens/bioLogin.dart';
import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
   Widget build(BuildContext context) {
    return context.watch<AuthStatus>().loggedIn ? MyBioNote() : BioLogin();
  }
}
