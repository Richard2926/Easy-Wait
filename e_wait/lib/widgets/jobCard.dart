import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:flutter/material.dart';
import 'package:e_wait/theme/apptheme.dart';

class RoomCard extends StatelessWidget {

  final bool isLast;
  final DocumentSnapshot room;
  final Function(String) onView;
  final bool ready;

  RoomCard({
    Key key,
    @required this.onView,
    @required this.isLast,
    @required this.room,
    @required this.ready,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int no;
    if(!ready){
      no = room['queue'].indexOf(GlobalData.user["uid"]);
    }
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 15, right: ((isLast == true)? 10 : 0)),
      child: RawMaterialButton(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: "${room['id']}",
                        child: Image.network(
                          room['url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 8),
                    child: Text(room['name'],

                        style: TextStyle(
                          fontFamily: AppTheme.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: -0.05,
                          color: AppTheme.black,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0, left: 8),
                    child: Text(ready ? "": "Spot No.$no in line",

                        style: TextStyle(
                          fontFamily: AppTheme.font,
                          fontWeight: FontWeight.w200,
                          fontSize: 13,
                          letterSpacing: 0.55,
                          color: AppTheme.grey,
                        )),
                  ),

                ],
              ),
            ],
          ),
          onPressed: () => {
            onView(room['id'])
          },

          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0))),
    );
  }
}
