import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_wait/widgets/wave.dart';

import 'authentication/router.dart';
import 'backend/auth.dart';
import 'backend/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: MaterialApp(
        supportedLocales: [
          const Locale('en', 'US'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'E-Wait',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(),
      ),
    );
  }
}

