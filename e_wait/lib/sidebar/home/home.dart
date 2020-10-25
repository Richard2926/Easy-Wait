import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:e_wait/backend/auth.dart';
import 'package:e_wait/backend/auth_provider.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:e_wait/sidebar/home/apply/apply.dart';
import 'package:e_wait/theme/apptheme.dart';
import 'package:yorubanames/yorubanames.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';
import 'explore.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  String key;
  Widget tabBody = Container(
    color: AppTheme.lightBackground,
  );
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    tabBody = Explore();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void changePage(int index) {
    if (index != currentIndex) {
      if (index == 0) {
        tabBody = Explore();
      } else {
        tabBody = Apply();
      }
    }
    setState(() {
      currentIndex = index;
    });
  }
  final _formKey = GlobalKey<FormState>();
  _showConfirmation(bool success, BuildContext context) {
    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 160,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text(
                      success? 'Yay!' : "Oops",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTheme.handFont,
                        fontWeight: FontWeight.w300,
                        color: success? AppTheme.foreground: AppTheme.red,
                        fontSize: 26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 13, left: 10, bottom: 10),
                      child: Text(
                        success? 'You will be notified when you are moved up the list!'
                            :"The code you entered either doesn't exist or you are already a part of it",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.font,
                          fontWeight: FontWeight.w300,
                          color: AppTheme.accent3,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right: 5, bottom: 5),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: AppTheme.background)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: AppTheme.background,
                          textColor: Colors.white,
                          child: Text("Ok".toUpperCase(),
                            style: TextStyle(
                              fontFamily: AppTheme.font,
                              fontWeight: FontWeight.w300,
                              color: AppTheme.accent3,
                              fontSize: 16,
                            ),)
                      ),
                    ),
                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //print(currentIndex);
    return new Scaffold(
//      appBar: new AppBar(title: new Text("Number Count")
//      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add Room",
        onPressed: () async {
          final AuthService auth = AuthProvider.of(context).auth;
          key = "";
          showDialog(
            context: context,
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 420,
                child: Column(
                  children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
              child: Image.network(
                              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                              fit: BoxFit.cover,
                            ),),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Text(
                                          'Join A Room!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.handFont,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.foreground,
                                            fontSize: 26,
                                          ),
                                        ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 13, left: 10, bottom: 10),
                            child: Text(
                              'Enter the code below and join the virtual line!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.font,
                                fontWeight: FontWeight.w300,
                                color: AppTheme.accent3,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      Form(
                          key: _formKey,
                          child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0, left: 45, right: 45),
                                  child: Container(
                                    height: 45,
                                    child: TextField(
                                      onChanged: (value){
                                          key = value;
                                      },
                                      style: TextStyle(
                                        fontFamily: AppTheme.font,
                                        fontWeight: FontWeight.w300,
                                        color: AppTheme.accent3,
                                        fontSize: 14,
                                      ),
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          filled: false,
                                          hintStyle: new TextStyle(
                                            fontFamily: AppTheme.font,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.accent3,
                                            fontSize: 14,
                                          ),
                                          hintText: "Type in your code",

                                          fillColor: AppTheme.background),

                                    ),
                                  ),
                                )
                              ]
                          )
                      ),
                          Row(
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 5),
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: AppTheme.background)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    color: AppTheme.background,
                                    textColor: Colors.white,
                                    child: Text("Cancel".toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: AppTheme.font,
                                        fontWeight: FontWeight.w300,
                                        color: AppTheme.accent3,
                                        fontSize: 16,
                                      ),)
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: AppTheme.accent3)),
                                  onPressed: () async{
                                    bool result = await auth.addRoom(key);
                                    Navigator.of(context).pop();
                                    print(result);
                                    _showConfirmation(result, context);
                                  },
                                  color: AppTheme.accent3,
                                  textColor: Colors.white,
                                  child: Text("Join".toUpperCase(),
                                      style: TextStyle(
                                                    fontFamily: AppTheme.font,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppTheme.background,
                                                    fontSize: 16,
                                                  ),)
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),

                    )
                  ],
                ),
              ),
            ),
          );
          // if(GlobalData.verified == null || GlobalData.verified == false){
          //   GlobalData.verified = await auth.isEmailVerified();
          // }
          //
          //
          // if (GlobalData.verified) {
          //
          // } else {
          //   showDialog(
          //       context: context,
          //       builder: (_) => NetworkGiffyDialog(
          //             buttonOkColor: AppTheme.accent3,
          //             buttonCancelColor: AppTheme.background,
          //             buttonCancelText: Text(
          //               'Cancel',
          //               style: TextStyle(
          //                 fontFamily: AppTheme.font,
          //                 fontWeight: FontWeight.w300,
          //                 color: AppTheme.accent3,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           buttonOkText: Text(
          //           'Join',
          //           style: TextStyle(
          //             fontFamily: AppTheme.font,
          //             fontWeight: FontWeight.w300,
          //             color: AppTheme.background,
          //             fontSize: 16,
          //           ),
          //         ),
          //             key: Key("Join Room"),
          //             image: Image.network(
          //               "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
          //               fit: BoxFit.cover,
          //             ),
          //             entryAnimation: EntryAnimation.BOTTOM_RIGHT,
          //             title: Text(
          //               'Join A Room!',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontFamily: AppTheme.handFont,
          //                 fontWeight: FontWeight.w300,
          //                 color: AppTheme.foreground,
          //                 fontSize: 26,
          //               ),
          //             ),
          //             description: Text(
          //               'This is to prevent unauthorized users. Thank you for your '
          //               'understanding.',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontFamily: AppTheme.font,
          //                 fontWeight: FontWeight.w300,
          //                 color: AppTheme.accent3,
          //                 fontSize: 14,
          //               ),
          //             ),
          //             onlyOkButton: false,
          //             onOkButtonPressed: () async {
          //               //Navigator.of(context).pop();
          //             },
          //           ));
          // }
        },
        child: Icon(Icons.add),
        backgroundColor: AppTheme.accent3,
      ),
      backgroundColor: AppTheme.lightBackground,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),

        elevation: 20,
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new
        hasInk: true,
        //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: AppTheme.foreground,
              icon: Icon(
                Icons.dashboard,
                color: AppTheme.accent3,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: AppTheme.foreground,
              ),
              title: Text(
                "My Rooms",
                style: TextStyle(
                  fontFamily: AppTheme.font,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  letterSpacing: -0.05,
                  color: AppTheme.accent3,
                ),
              )),
          BubbleBottomBarItem(
              backgroundColor: AppTheme.accent1,
              icon: Icon(
                Icons.menu,
                color: AppTheme.accent3,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: AppTheme.accent1,
              ),
              title: Text(
                "Near Me",
                style: TextStyle(
                  fontFamily: AppTheme.font,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  letterSpacing: -0.05,
                  color: AppTheme.accent3,
                ),
              ))
        ],
      ),
      body: tabBody,
//      body:  AnimatedSwitcher(
//        duration: const Duration(milliseconds: 500),
//        transitionBuilder: (Widget child, Animation<double> animation) {
//          return ScaleTransition(child: child, scale: animation);
//        },
//        child: tabBody,
//      ),
    );
  }
}
