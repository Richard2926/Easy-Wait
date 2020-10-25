import 'package:e_wait/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:e_wait/widgets/jobCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => new _ExploreState();
}

class _ExploreState extends State<Explore> {

  Widget horizontalSliders(String title, List<DocumentSnapshot> rooms, bool ready) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20, top: 10),
                    child: Text(title,
                        style: TextStyle(
                          fontFamily: AppTheme.font,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          letterSpacing: -0.05,
                          color: AppTheme.black,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height/3.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: rooms.length ,
              itemBuilder: (BuildContext context, int index) {

                DocumentSnapshot room = rooms[index];
                bool last =  (index == rooms.length - 1);

                return RoomCard(
                    ready: ready,
                    room: room,
                    isLast: last,
                    onView: (String jobId) => {
                      print(jobId)
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWaitingScreen() {
    return Padding (
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/ 3, bottom: 0),
        child: SpinKitChasingDots(
          color: AppTheme.cyan,
          size: 50.0,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height/ 1,
          child: Column(
            children: [
              StreamBuilder(
                stream: GlobalData.acceptedStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> accepted) {

                  switch (accepted.connectionState) {
                    case ConnectionState.active:
                      return horizontalSliders("Ready to attend", accepted.data.documents, true);
                      break;
                    default:
                      return (Container(height: 0));
                      break;
                  }
                },
              ),
              StreamBuilder(
                stream: GlobalData.myRoomsStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> myRooms) {

                  switch (myRooms.connectionState) {
                    case ConnectionState.active:
                      return horizontalSliders("My Current Waiting List", myRooms.data.documents, false);
                      break;
                    default:
                      return (_buildWaitingScreen());
                      break;
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
