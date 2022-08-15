import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum OddFormat { DECIMAL, FRACTION, AMERICAN }

class OddFormatSelectionDialog extends StatefulWidget {
  final BuildContext context;
  final SettingsProvider bloc;

  OddFormatSelectionDialog(this.context, this.bloc);

  @override
  _OddFormatSelectionDialogState createState() =>
      _OddFormatSelectionDialogState(context, bloc);
}

class _OddFormatSelectionDialogState extends State<OddFormatSelectionDialog> {
  OddFormat? _oddFormatGroup;
  SettingsProvider bloc;

  BuildContext context;

  _OddFormatSelectionDialogState(this.context, this.bloc);

  @override
  void initState() {
    super.initState();
    String format = bloc.oddFormatSelection;
    switch (format) {
      case 'decimal':
        _oddFormatGroup = OddFormat.DECIMAL;
        break;
      case 'fraction':
        _oddFormatGroup = OddFormat.FRACTION;
        break;
      case 'american':
        _oddFormatGroup = OddFormat.AMERICAN;
        break;
      default:
        _oddFormatGroup = OddFormat.DECIMAL;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      semanticLabel: AppLocalizations.of(context)!.selectOddFormat,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        AppLocalizations.of(context)!.selectOddFormat,
        textAlign: TextAlign.center,
      ),
      children: [
        RadioListTile(
          value: OddFormat.DECIMAL,
          groupValue: _oddFormatGroup,
          onChanged: (OddFormat? value) {
            setState(() {
              _oddFormatGroup = value;
            });
          },
          title: Text(
            AppLocalizations.of(context)!.decimal,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
        RadioListTile(
          value: OddFormat.FRACTION,
          groupValue: _oddFormatGroup,
          onChanged: (OddFormat? value) {
            setState(() {
              _oddFormatGroup = value;
            });
          },
          title: Text(
            AppLocalizations.of(context)!.fraction,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
        RadioListTile(
          value: OddFormat.AMERICAN,
          groupValue: _oddFormatGroup,
          onChanged: (OddFormat? value) {
            setState(() {
              _oddFormatGroup = value;
            });
          },
          title: Text(
            AppLocalizations.of(context)!.american,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
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
                switch (_oddFormatGroup) {
                  case OddFormat.DECIMAL:
                    await bloc.setSharedPreferencesOddFormat('decimal');
                    break;
                  case OddFormat.FRACTION:
                    await bloc.setSharedPreferencesOddFormat('fraction');
                    break;
                  case OddFormat.AMERICAN:
                    await bloc.setSharedPreferencesOddFormat('american');
                    break;
                  case null:
                    await bloc.setSharedPreferencesOddFormat('decimal');
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
