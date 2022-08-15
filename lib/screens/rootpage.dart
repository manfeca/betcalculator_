import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/screens/settings_screen.dart';
import 'package:bettingoddscalculator/screens/single_odd_calculation_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdi/mdi.dart';

import 'best_odds_calculator.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  final PageController controller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20.0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          selectedItemColor:
              Provider.of<SettingsProvider>(context).darkModeSetting
                  ? Colors.white
                  : Theme.of(context).primaryColor,
          currentIndex: currentIndexPage,
          onTap: (value) {
            switch (value) {
              case 0:
                setState(() {
                  currentIndexPage = value;
                  controller.jumpToPage(value);
                });
                break;
              case 1:
                setState(() {
                  currentIndexPage = value;
                  controller.jumpToPage(value);
                });
                break;
              case 2:
                setState(() {
                  currentIndexPage = value;
                  controller.jumpToPage(value);
                });

                break;
              default:
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Mdi.calculatorVariant,
                semanticLabel:
                    AppLocalizations.of(context)!.singleOddCalculator,
              ),
              label: AppLocalizations.of(context)!.singleOddCalculator,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Mdi.trophy,
                semanticLabel: AppLocalizations.of(context)!.bestOddsCalculator,
              ),
              label: AppLocalizations.of(context)!.bestOddsCalculator,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                semanticLabel: AppLocalizations.of(context)!.settings,
              ),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SingleOddCalculationScreen(),
            BestOddsCalculator(),
            SettingsScreen(),
          ],
        ),
      ),
    );
  }
}
