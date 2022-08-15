import 'package:flutter/material.dart';

class FairValueSemaforo extends StatelessWidget {
  final double? expectedValue;

  const FairValueSemaforo({this.expectedValue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expectedValue!.isNegative) {
      return Icon(
        Icons.circle,
        size: 16.0,
        color: Colors.red[900],
      );
    } else if (!expectedValue!.isNegative && expectedValue! < 1.0) {
      return Icon(
        Icons.circle,
        size: 16.0,
        color: Colors.orange,
      );
    } else if (expectedValue! > 1) {
      return Icon(
        Icons.circle,
        size: 16.0,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.circle,
        size: 16.0,
        color: Colors.transparent,
      );
    }
  }
}
