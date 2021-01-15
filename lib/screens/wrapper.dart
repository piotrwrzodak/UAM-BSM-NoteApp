import 'package:bsm_noteapp/screens/bioLogin.dart';
import 'package:bsm_noteapp/screens/chooseLogin.dart';
import 'package:bsm_noteapp/screens/home.dart';
import 'package:bsm_noteapp/screens/login.dart';
import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

   @override
  void initState() {
    super.initState();
    HiveHelper.init();
  }

  @override
   Widget build(BuildContext context) {
    return context.watch<AuthStatus>().loggedIn ? 
      MyNote() : context.watch<AuthStatus>().loginMethod == "password" ? 
      MyLogin() : context.watch<AuthStatus>().loginMethod == "fingerprint" ? 
      BioLogin() : ChooseLogin();
  }
}
class HiveHelper {
  static void init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.initFlutter(dir.path);
    print('[Debug] Hive path: ${dir.path}');
  }
}