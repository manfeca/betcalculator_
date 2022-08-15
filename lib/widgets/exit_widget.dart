import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdi/mdi.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExitWidget extends StatelessWidget {
  final BuildContext context;

  const ExitWidget(this.context);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog<void>(

          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Text(AppLocalizations.of(context)!.exitAppQuestion),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.exitAppText),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:
                      Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.ok.toUpperCase()),
                  onPressed: () {
                    // SystemNavigator.pop();
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
              ],
            );
          },
        );
      },
      icon: Icon(Mdi.exitToApp),
    );
  }
}
