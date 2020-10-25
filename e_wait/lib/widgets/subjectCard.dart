import 'package:flutter/cupertino.dart';
import 'package:e_wait/theme/apptheme.dart';

class SubjectCard extends StatelessWidget {
  final String title, count, imagePath;

  SubjectCard(
      this.title,
      this.count,
      this.imagePath,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, left:16, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 140.0,
            width: 250.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(24),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.foreground,
                      blurRadius: 15.0,
                      offset: Offset(0.75, 0.95))
                ],
                color: AppTheme.foreground),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '$title',
              style: TextStyle(
                fontFamily: AppTheme.font,
                fontWeight: FontWeight.w300,
                color: AppTheme.accent3,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}