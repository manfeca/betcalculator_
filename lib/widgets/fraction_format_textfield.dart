import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/blocs/single_odd_calc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;

class FractionFormatTextField extends StatelessWidget {
  const FractionFormatTextField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final SingleOddCalculationProvider bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: bloc.oddTextFieldController,
              autocorrect: true,
              onSubmitted: (value) {
                //  bloc.doCalculation(value);
              },
              autofocus: false,
              // cursorHeight: 24.0,
              style: Constants.textFieldFontStyle,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              maxLength: 6,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              showCursor: true,
              enableInteractiveSelection: true,
              decoration: Provider.of<SettingsProvider>(context).darkModeSetting
                  ? Constants.getTextFieldDarkDecoration(context)
                      .copyWith(hintText: "5")
                  : Constants.getTextFieldLightDecoration(context)
                      .copyWith(hintText: "5"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "/",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: bloc.oddTextFieldDenominatorController,
              autocorrect: true,
              onSubmitted: (value) {
                //  bloc.doCalculation(value);
              },
              autofocus: false,
              style: Constants.textFieldFontStyle,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              maxLength: 6,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              showCursor: true,
              enableInteractiveSelection: true,
              decoration: Provider.of<SettingsProvider>(context).darkModeSetting
                  ? Constants.getTextFieldDarkDecoration(context)
                      .copyWith(hintText: "2")
                  : Constants.getTextFieldLightDecoration(context)
                      .copyWith(hintText: "2"),
            ),
          ),
        ],
      ),
    );
  }
}
