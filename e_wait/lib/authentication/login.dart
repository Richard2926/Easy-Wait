import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:e_wait/backend/auth.dart';
import 'package:e_wait/backend/auth_provider.dart';
import 'package:e_wait/theme/apptheme.dart';

class Login extends StatefulWidget {
  const Login({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}


class _LoginPageState extends State<Login> {

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    //print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async{

      final AuthService auth = AuthProvider.of(context).auth;
      try{
        String userId = await auth.signIn(data.name, data.password);
        print("Signed in : $userId");
      }catch (error){
        print(error);
        return "Incorrect Credentials";
      }


      return null;
    });
  }
  Future<String> _signUp(LoginData data) {
    //print('Name: ${data.name}, Password: ${data.password}');
    Future.delayed(Duration(seconds: 1));
    return Future.delayed(loginTime).then((_) async{

      final AuthService auth = AuthProvider.of(context).auth;

      try{
        String userId = await auth.signUp(data.name, data.password);
        //auth.sendEmailVerification();
        print("Signed Up : $userId");
      }catch (error){
        print(error);
        return "Weak Password";
      }
      return null;
    });
  }
  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return 'Username not exists';
      //return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      messages: LoginMessages(),
      theme: LoginTheme(

        primaryColor: AppTheme.foreground,
        accentColor:  AppTheme.accent3,
        errorColor:   AppTheme.accent1,

        titleStyle: TextStyle(
        fontFamily: AppTheme.handFont,
        fontWeight: FontWeight.w300,
        fontSize: 32,
        letterSpacing: -0.05,
        color: AppTheme.white,
      ),
        bodyStyle: TextStyle(
        fontFamily: AppTheme.font,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        letterSpacing: -0.05,
        color: AppTheme.black,
      ),
        buttonStyle: TextStyle(
          fontFamily: AppTheme.font,
          fontWeight: FontWeight.w300,
          fontSize: 16,
          letterSpacing: -0.05,
          color: AppTheme.white,
        ),
      ),
      title: AppTheme.appName,
      //logo: 'assets/logo.png',
      onLogin: _authUser,
      onSignup: _signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pop();
        widget.onSignedIn();
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}