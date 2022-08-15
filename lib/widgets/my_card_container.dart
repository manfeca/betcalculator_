import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCardContainer extends StatelessWidget {
  final Widget? child;
  final double? preferedElevation;
  final double topMargin;
  final double bottomMargin;

  const MyCardContainer({this.topMargin = 16.0, this.bottomMargin = 16.0, this.preferedElevation, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: topMargin, bottom: bottomMargin),
      elevation: preferedElevation,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
         /*side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ), */
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
