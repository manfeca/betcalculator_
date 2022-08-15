import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ThemeColors { INDIGO, GREEN, DEEPPURPLE, NAVY }
// deleted brown and red from app
// enum ThemeColors { INDIGO, GREEN, DEEPPURPLE, BROWN, RED, NAVY }

class ThemeColorSelectionDialog extends StatefulWidget {
  final BuildContext context;
  final SettingsProvider bloc;

  ThemeColorSelectionDialog(this.context, this.bloc);

  @override
  _ThemeColorSelectionDialogState createState() =>
      _ThemeColorSelectionDialogState(context, bloc);
}

class _ThemeColorSelectionDialogState extends State<ThemeColorSelectionDialog> {
  ThemeColors? _themeColorGroup;
  SettingsProvider bloc;

  BuildContext context;

  _ThemeColorSelectionDialogState(this.context, this.bloc);

  @override
  void initState() {
    super.initState();
    String format = bloc.themeColorSelection;
    switch (format) {
      case 'indigo':
        _themeColorGroup = ThemeColors.INDIGO;
        break;
      case 'green':
        _themeColorGroup = ThemeColors.GREEN;
        break;
      case 'deeppurple':
        _themeColorGroup = ThemeColors.DEEPPURPLE;
        break;
      /*   case 'brown':
        _themeColorGroup = ThemeColors.BROWN;
        break;
      case 'red':
        _themeColorGroup = ThemeColors.RED;
        break; */
      case 'navy':
        _themeColorGroup = ThemeColors.NAVY;
        break;
      default:
        _themeColorGroup = ThemeColors.NAVY;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        AppLocalizations.of(context)!.selectThemeColor,
        textAlign: TextAlign.center,
      ),
      children: [
        RadioListTile(
          activeColor: Color(0xFF6D8299),
          value: ThemeColors.INDIGO,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.indigo),
        ),
        RadioListTile(
          activeColor: Color(0xFF326B83),
          value: ThemeColors.GREEN,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.green),
        ),
        RadioListTile(
          activeColor: Colors.deepPurple,
          value: ThemeColors.DEEPPURPLE,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.deeppurple),
        ),
        /*  RadioListTile(
          activeColor: Color(0xFF4A403A),
          value: ThemeColors.BROWN,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.brown),
        ),
        RadioListTile(
          activeColor: Colors.red[900],
          value: ThemeColors.RED,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.red),
        ), */
        RadioListTile(
          activeColor: Color(0xFF091353),
          value: ThemeColors.NAVY,
          groupValue: _themeColorGroup,
          onChanged: (ThemeColors? value) {
            setState(() {
              _themeColorGroup = value;
            });
          },
          title: Text(AppLocalizations.of(context)!.navy),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
            ),
            TextButton(
              onPressed: () async {
                switch (_themeColorGroup) {
                  case ThemeColors.GREEN:
                    await bloc.setSharedPreferencesThemeColor('green');
                    break;
                  case ThemeColors.DEEPPURPLE:
                    await bloc.setSharedPreferencesThemeColor('deeppurple');
                    break;
                  /*   case ThemeColors.BROWN:
                    await bloc.setSharedPreferencesThemeColor('brown');
                    break; */
                  case ThemeColors.INDIGO:
                    await bloc.setSharedPreferencesThemeColor('indigo');
                    break;
                  /*    case ThemeColors.RED:
                    await bloc.setSharedPreferencesThemeColor('red');
                    break; */
                  case ThemeColors.NAVY:
                    await bloc.setSharedPreferencesThemeColor('navy');
                    break;
                  case null:
                    await bloc.setSharedPreferencesThemeColor('navy');
                    break;
                }

                Navigator.pop(context);
              },
              child: Text("SET"),
            ),
          ],
        ),
      ],
    );
  }
}
