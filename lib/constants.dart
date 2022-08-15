import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

const TextStyle formHeadingTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

const TextStyle resultHeadingTextStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.normal,
);

const TextStyle textFieldFontStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const TextStyle resultTextFieldFontStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const Icon appBarLogo = Icon(Mdi.soccer);

InputDecoration getTextFieldLightDecoration(BuildContext context) =>
    InputDecoration(
      fillColor: Theme.of(context).primaryColorLight, //Colors.grey[200],
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
    );

InputDecoration getTextFieldDarkDecoration(BuildContext context) =>
    InputDecoration(
      // fillColor: Colors.grey[100],
      // filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColorLight,
          width: 1.0,
        ),
        //  borderRadius: BorderRadius.circular(10.0),
      ),
    );

InputDecoration getResultTextFieldLightDecoration(BuildContext context) =>
    InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
      fillColor: Colors.transparent,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        /*   borderSide: BorderSide(
          color: Theme.of(context).primaryColorLight,
          width: 1.0,
        ),*/
        //   borderRadius: BorderRadius.circular(10.0),
      ),
    );

InputDecoration getResultTextFieldDarkDecoration(BuildContext context) =>
    InputDecoration(
      fillColor: Colors.transparent,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        /*  borderSide: BorderSide(
          color: Theme.of(context).primaryColorLight,
          width: 1.0,
        ),*/
      ),
    );
