import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/widgets/decoration/bottom_appbar_decoration.dart';
import 'package:bettingoddscalculator/widgets/glossary_bottom_sheet.dart';
import 'package:bettingoddscalculator/widgets/my_card_container.dart';
import 'package:bettingoddscalculator/widgets/odd_format_selection_dialog.dart';
import 'package:bettingoddscalculator/widgets/theme_color_selection.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart' as Constants;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SettingsProvider>(context);
    Color? iconColor =
        Provider.of<SettingsProvider>(context).darkModeSetting == false
            ? bloc.primaryThemeColor
            : null;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Constants.appBarLogo,
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
        bottom: PreferredSize(
          child: BottomAppbarDecoration(),
          preferredSize: Size(MediaQuery.of(context).size.width, 20.0),
        ),
      ),
      body: ListView(
        children: [
          // ListTile(
          //   title:
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
            ),
            child: Text(
              AppLocalizations.of(context)!.general.toUpperCase(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          // ),
          MyCardContainer(
            topMargin: 0,
            bottomMargin: 0,
            preferedElevation: 8.0,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      transitionDuration: Duration(milliseconds: 300),
                      barrierDismissible: true,
                      barrierLabel: '',
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: OddFormatSelectionDialog(context, bloc),
                          ),
                        );
                      },
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        throw Exception;
                      },
                    );
                  },
                  leading: Icon(
                    Mdi.numeric,
                    color: iconColor,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.oddFormat,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  subtitle: Text(AppLocalizations.of(context)!.selectOddFormat),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GlossaryScreen()),
                    );
                  },
                  leading: Icon(
                    Icons.list,
                    color: iconColor,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.glossary,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  subtitle:
                      Text(AppLocalizations.of(context)!.glossarySubtitle),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
              top: 16.0,
            ),
            child: Text(
              AppLocalizations.of(context)!.theme.toUpperCase(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),

          MyCardContainer(
            topMargin: 0,
            bottomMargin: 0,
            preferedElevation: 8.0,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      transitionDuration: Duration(milliseconds: 300),
                      barrierDismissible: true,
                      barrierLabel: '',
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: ThemeColorSelectionDialog(context, bloc),
                          ),
                        );
                      },
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        throw Exception;
                      },
                    );

                    /*  showDialog(
                        context: context,
                        builder: (context) {
                          return ThemeColorSelectionDialog(context, bloc);
                        }); */
                  },
                  leading: Icon(
                    Icons.colorize,
                    color: iconColor,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.themeColor,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle:
                      Text(AppLocalizations.of(context)!.selectThemeColor),
                  trailing: Icon(
                    Icons.circle,
                    size: 24.0,
                    color: Provider.of<SettingsProvider>(context)
                        .primaryThemeColor,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.dark_mode,
                    color: iconColor,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.darkMode,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(AppLocalizations.of(context)!.selectDarkTheme),
                  trailing: Switch(
                    value: bloc.darkModeSetting,
                    onChanged: (value) {
                      bloc.setDarkModeSetting(value);
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
              top: 16.0,
            ),
            child: Text(
              AppLocalizations.of(context)!.aboutThis.toUpperCase(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),

          MyCardContainer(
            topMargin: 0,
            bottomMargin: 0,
            preferedElevation: 8.0,
            child: ListTile(
              onTap: () {
                showGeneralDialog(
                  barrierColor: Colors.black.withOpacity(0.5),
                  barrierDismissible: true, // user must tap button!
                  transitionBuilder: (context, a1, a2, widget) {
                    return Transform.scale(
                      scale: a1.value,
                      child: Opacity(
                        opacity: a1.value,
                        child: SimpleDialog(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            AppLocalizations.of(context)!.aboutThis,
                            textAlign: TextAlign.center,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          children: [
                            ListBody(
                              children: <Widget>[
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.developerName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    //      fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 300),
                  barrierLabel: '',
                  context: context,
                  pageBuilder: (context, animation1, animation2) {
                    throw Exception;
                  },
                );
              },
              leading: Icon(
                Mdi.soccer,
                color: iconColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.appName,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              //   subtitle: Text(AppLocalizations.of(context)!.developerName),
              trailing: Text(
                AppLocalizations.of(context)!.versionNumber,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
