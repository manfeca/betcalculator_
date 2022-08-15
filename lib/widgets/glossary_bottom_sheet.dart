import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

import 'decoration/bottom_appbar_decoration.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen();
  @override
  State<StatefulWidget> createState() {
    return GlossaryScreenState();
  }
}

class GlossaryScreenState extends State {
  List<bool> _isOpen = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.glossary),
          centerTitle: true,
          bottom: PreferredSize(
            child: BottomAppbarDecoration(),
            preferredSize: Size(MediaQuery.of(context).size.width, 20.0),
          ),
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 500),
            expandedHeaderPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isOpen[panelIndex] = !isExpanded;
              });
            },
            children: [
              //  ========= americaon odd definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(
                      context, AppLocalizations.of(context)!.americanOddTerm);
                },
                isExpanded: _isOpen[0],
                body: buildExpansionContainer(
                    context, AppLocalizations.of(context)!.americanOddDef),
              ),

              //  ========= FRACTIONAL odd definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(
                      context, AppLocalizations.of(context)!.fractionalOddTerm);
                },
                isExpanded: _isOpen[1],
                body: buildExpansionContainer(
                    context, AppLocalizations.of(context)!.fractionalOddDef),
              ),

              //  ========= DECIMAL odd definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(
                      context, AppLocalizations.of(context)!.decimalOddTerm);
                },
                isExpanded: _isOpen[2],
                body: buildExpansionContainer(
                    context, AppLocalizations.of(context)!.decimalOddDef),
              ),

              //  ========= IMPLIED PROBABILITY definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(context,
                      AppLocalizations.of(context)!.impliedProbabilityTerm);
                },
                isExpanded: _isOpen[3],
                body: buildExpansionContainer(context,
                    AppLocalizations.of(context)!.impliedProbabilityDef),
              ),

              //  ========= consensus probability definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(context,
                      AppLocalizations.of(context)!.consensusProbabilityTerm);
                },
                isExpanded: _isOpen[4],
                body: buildExpansionContainer(context,
                    AppLocalizations.of(context)!.consensusProbabilityDef),
              ),

              //  ========= consensus probability definition ==========
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return buildListTile(
                      context, AppLocalizations.of(context)!.expectedValueTerm);
                },
                isExpanded: _isOpen[5],
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 32.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          " ${AppLocalizations.of(context)!.expectedValueDef}\n",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16.0,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                  "${AppLocalizations.of(context)!.greenCircleMeaning}\n"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16.0,
                            color: Colors.orange,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                  "${AppLocalizations.of(context)!.orangeCircleMeaning}\n"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                  "${AppLocalizations.of(context)!.redCircleMeaning}\n"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildListTile(BuildContext context, String term) {
    var bloc = Provider.of<SettingsProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Mdi.circle,
              size: 14.0,
              color: Provider.of<SettingsProvider>(context).darkModeSetting ==
                      false
                  ? bloc.primaryThemeColor
                  : null,
            ),
          ],
        ),
        title: Text(
          term,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container buildExpansionContainer(
      BuildContext context, String termDefinition) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        child: Text(
          termDefinition,
          textAlign: TextAlign.justify,
        ));
  }
}
