import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_wait/theme/apptheme.dart';

class BankCard extends StatelessWidget {

  final bool isLast;
  final DocumentSnapshot bank;
  final Function(String) onView;

  BankCard({
    Key key,
    @required this.onView,
    @required this.isLast,
    @required this.bank,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 15, right: 10),
      child: RawMaterialButton(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: "${bank['id']}",
                        child: Image.network(
                          bank['url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 6.0,
                  //   right: 6.0,
                  //   child: Card(
                  //     shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(3.0)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(4.0),
                  //       child: (product['available'] && !(product['stock'] == 0)) ? Text(
                  //         " AVAILABLE ",
                  //         style: TextStyle(
                  //           fontSize: 10,
                  //           color: Colors.green,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ) : Text(
                  //         (!product['available'])? " DISABLED ": " OUT OF STOCK " ,
                  //         style: TextStyle(
                  //           fontSize: 10,
                  //           color: Colors.redAccent,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 8),
                    child: Text(bank['name'],

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
                    child: Text("${bank['jobs']} Categories",

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
            onView(bank['id'])
          },

          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0))),
    );
  }
}
