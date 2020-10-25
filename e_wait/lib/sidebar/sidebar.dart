import 'package:flutter/material.dart';
import 'package:e_wait/authentication/login.dart';
import 'package:e_wait/misc/globaldata.dart';
import 'package:e_wait/sidebar/home/home.dart';
import 'package:e_wait/theme/apptheme.dart';

class SideBar extends StatefulWidget {
  const SideBar({this.onSignedOut});

  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>{
  final GlobalKey _scaffoldKey = new GlobalKey();
  String selected = "Home";
  String title = "Home";
  Widget tabBody = Container(
    color: AppTheme.white,
  );
  @override
  void initState() {
    super.initState();
    tabBody = Home();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.foreground,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: AppTheme.font,
              fontWeight: FontWeight.w300,
              fontSize: 27,
              letterSpacing: -0.05,
              color: AppTheme.white,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.foreground,
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 00.0),
                  child: Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.foreground,
                      ),
                    ),
                    child: Text(
                      'Easy Waiting !',
                      style: TextStyle(
                        fontFamily: AppTheme.font,
                        fontWeight: FontWeight.w300,
                        color: AppTheme.white,
                        fontSize: 24,
                      ),
                    ),
                  )),
            ),
            listItem("Home", Icons.message),
            listItem("History", Icons.trending_up),
            listItem("Ask Help", Icons.help_outline),
            listItem("Feedback", Icons.question_answer),
            listItem("Settings", Icons.settings),
          ],
        ),
      ),
      body: AnimatedSwitcher(duration: Duration(seconds: 1),child: tabBody),
    );
  }

  ListTile listItem(String name, IconData icon) {
    return ListTile(
      leading: Icon(icon, color:  selected == name ? AppTheme.foreground:AppTheme
          .accent3),
      title: Text(name,
                  style: TextStyle(
          fontFamily: AppTheme.font,
          fontWeight: FontWeight.w300,
          color: selected == name ? AppTheme.foreground: AppTheme.accent3,
          fontSize: 16,
        ),),
      hoverColor: AppTheme.accent2,
      onTap: () async{
        setState(() {
          selected = name;
        });

         Navigator.of(context).pop();
        //await Future.delayed(Duration(milliseconds: 500));
        switchPage(name);
      //_controller.forward(),
        //Navigator.of(context).pop()

      },
    );
  }
  void switchPage(String pageName){
    switch(pageName){
      case "Home":
        setState(() {
          title = "Home";
          tabBody = Home();
        });
        break;
      case "History":
        setState(() {
          title = "My History";
        });
        break;
      case "Ask Help":
        setState(() {
          title = "Help";
        });
        break;
      case "Feedback":
        setState(() {
          title = "Feedback";
        });
        break;
      case "Settings":
        setState(() {
          title = "Settings";
        });
        break;

    }

  }
}
