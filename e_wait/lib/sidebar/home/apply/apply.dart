import 'package:e_wait/misc/globaldata.dart';
import 'package:e_wait/theme/apptheme.dart';
import 'package:e_wait/widgets/bankCard.dart';
import 'package:e_wait/widgets/subjectCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Apply extends StatefulWidget {

  @override
  _ApplyState createState() => new _ApplyState();
}

class _ApplyState extends State<Apply> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height/ 1,
        child: StreamBuilder(
          stream: GlobalData.nearMeStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> nearMe) {

            switch (nearMe.connectionState) {
              case ConnectionState.active:
                  return Container(height: 0,);
                  break;
              default:
                return (_buildWaitingScreen());
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildWaitingScreen() {
    return SpinKitChasingDots(
      color: AppTheme.cyan,
      size: 50.0,
    );
  }
}