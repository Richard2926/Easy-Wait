import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_wait/backend/auth.dart';
import 'package:e_wait/backend/auth_provider.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:e_wait/sidebar/sidebar.dart';
import 'package:e_wait/theme/apptheme.dart';
import 'package:e_wait/widgets/fullscreenload.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'login.dart';

class Router extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouterState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RouterState extends State<Router> {

  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthService auth = AuthProvider.of(context).auth;
    //auth.signOut();
    if(GlobalData.adminGlobalStream == null) GlobalData.adminGlobalStream = auth.adminGlobal();
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        //print("Messing around");
        if(authStatus == AuthStatus.signedIn && GlobalData.userStream == null){
          //print("Messing around more");
          GlobalData.userStream = auth.userStream(userId);
          GlobalData.myRoomsStream = auth.getMyRooms(userId);
          GlobalData.acceptedStream = auth.getAccepted(userId);
        }
        print("Setting Login Status : $authStatus");
      });
    });
  }

  Future<void> _signedIn() async{
    final AuthService auth = AuthProvider.of(context).auth;
    String user = await auth.currentUser();

    GlobalData.adminGlobalStream = auth.adminGlobal();
    GlobalData.userStream = auth.userStream(user);
    GlobalData.myRoomsStream = auth.getMyRooms(user);
    GlobalData.acceptedStream = auth.getAccepted(user);
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    final AuthService auth = AuthProvider.of(context).auth;


    GlobalData.adminGlobalStream = null;
    GlobalData.userStream = null;
    GlobalData.myRoomsStream = null;
    GlobalData.nearMeStream = null;
    GlobalData.acceptedStream = null;

    GlobalData.user = null;
    GlobalData.adminGlobal = null;
    GlobalData.nearMe = null;
    GlobalData.myRooms = null;
    GlobalData.accepted = null;

    authStatus = AuthStatus.notSignedIn;

    auth.signOut();

        setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    //_signedIn();
    return (authStatus == AuthStatus.signedIn) ? StreamBuilder(
      stream: GlobalData.userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
        switch (user.connectionState) {
          case ConnectionState.active:
            if(user.data.exists){
              GlobalData.user = user.data;
              GlobalData.active = GlobalData.user["active"];
              return StreamBuilder(
                stream: GlobalData.adminGlobalStream,
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> admin) {
                  switch (admin.connectionState) {
                    case ConnectionState.active:
                      GlobalData.adminGlobal = admin.data;
                      //print("Change in Admin Data: ${admin.data.data}");
                      switch (authStatus) {
                        case AuthStatus.notDetermined:
                          return FullScreenLoad();
                        case AuthStatus.notSignedIn:
                          return Login(
                            onSignedIn: _signedIn,
                          );
                          // return OnBoardingPage(
                          //   onSignedIn: _signedIn,);
                        case AuthStatus.signedIn:
                          print("Reached");
                          return SideBar(
                            onSignedOut: _signedOut,
                          );
                        default:
                          return FullScreenLoad();
                      }
                      break;

                    default:
                      return FullScreenLoad();
                      break;
                  }
                },
              );
            }else{
              return FullScreenLoad();
            }

            break;

          default:
            return FullScreenLoad();
            break;
        }
      },
    ) : Login(
      onSignedIn: _signedIn,
    );

  }

}
