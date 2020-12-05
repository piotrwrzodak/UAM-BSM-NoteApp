import 'package:bsm_noteapp/screens/home.dart';
import 'package:bsm_noteapp/screens/login.dart';
import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return context.watch<AuthStatus>().loggedIn ? MyNote() : MyLogin();
  }
}