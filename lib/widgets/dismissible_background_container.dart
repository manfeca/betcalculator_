/*=====================================
// This class returns the background
// decoration to "Delete" or "Edit" a 
// Dismissible container.
//  
// v 1.0.0
// author: manfeca@gmail.com (Manuel F. Camargo)
// ===================================*/

import 'package:flutter/material.dart';

enum BackgroundType { Edit, Delete }

class DismissibleBackgroundContainer extends StatelessWidget {
  final BackgroundType backgroundType;

  const DismissibleBackgroundContainer({required this.backgroundType});

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return backgroundType == BackgroundType.Edit
        ? buildEditContainer()
        : buildDeleteContainer();
  }

  Widget buildDeleteContainer() {
    return Container(
     //  color: Colors.red[900],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.red[900],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
            ),
            Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }

  Widget buildEditContainer() {
    return Container(
      color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
          ),
          Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
    );
  }
}
