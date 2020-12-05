import 'package:bsm_noteapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bsm_noteapp/screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AuthStatus(),
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        home: Wrapper(),
      );
  }
}

