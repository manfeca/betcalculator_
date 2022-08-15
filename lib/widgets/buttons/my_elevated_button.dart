import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget icon;
  final Widget label;
  final Function()? onPressed;
  final double? elevation;
  final MaterialStateProperty<Size?>? fixedSize;

  const MyElevatedButton({
    this.backgroundColor,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.elevation = 0.0,
    this.fixedSize,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        fixedSize: fixedSize,
        elevation: MaterialStateProperty.all<double?>(elevation),
        backgroundColor:
            MaterialStateProperty.all<Color>(this.backgroundColor!),
      ),
    );
  }
}
