import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:e_wait/theme/apptheme.dart';

class FullScreenLoad extends StatefulWidget {

//  ListItem(
//      {Key key,
//        @required this.title,
//        @required this.subtitle,
//        @required this.open})
//      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FullScreenLoadState();
}

class _FullScreenLoadState extends State<FullScreenLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: SpinKitPouringHourglass(
                color: AppTheme.foreground,
                size: MediaQuery.of(context).size.height/3,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
