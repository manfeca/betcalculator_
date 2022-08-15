import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/blocs/single_odd_calc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;

class DecimalAmericanFormatTextField extends StatelessWidget {
  const DecimalAmericanFormatTextField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final SingleOddCalculationProvider bloc;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bloc.oddTextFieldController,
      autocorrect: true,
      onSubmitted: (value) {
        //  bloc.doCalculation(value);
      },
      autofocus: false,
      style: Constants.textFieldFontStyle,
      keyboardType:
          Provider.of<SettingsProvider>(context).oddFormatSelection == 'decimal'
              ? TextInputType.numberWithOptions(decimal: true, signed: false)
              : TextInputType.numberWithOptions(decimal: false, signed: true),
      maxLength: 4,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      showCursor: true,
      enableInteractiveSelection: true,
      decoration: Provider.of<SettingsProvider>(context).darkModeSetting
          ? Constants.getTextFieldDarkDecoration(context).copyWith(
              hintText:
                  Provider.of<SettingsProvider>(context).oddFormatSelection ==
                          'decimal'
                      ? "2.1 , 1.8"
                      : "120 , -500",
            )
          : Constants.getTextFieldLightDecoration(context).copyWith(
              hintText:
                  Provider.of<SettingsProvider>(context).oddFormatSelection ==
                          'decimal'
                      ? "2.1 , 1.8"
                      : "120 , -500",
            ),
    );
  }
}
