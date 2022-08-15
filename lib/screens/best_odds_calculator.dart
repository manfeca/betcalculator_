import 'package:bettingoddscalculator/blocs/best_odd_provider.dart';
import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/blocs/single_odd_calc_provider.dart';
import 'package:bettingoddscalculator/resources/utility.dart';
import 'package:bettingoddscalculator/widgets/buttons/my_elevated_button.dart';
import 'package:bettingoddscalculator/widgets/decimal_american_format_textfield.dart';
import 'package:bettingoddscalculator/widgets/decoration/bottom_appbar_decoration.dart';
import 'package:bettingoddscalculator/widgets/dismissible_background_container.dart';
import 'package:bettingoddscalculator/widgets/fairvalue_semaforo.dart';
import 'package:bettingoddscalculator/widgets/fraction_format_textfield.dart';
import 'package:bettingoddscalculator/widgets/my_card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:bettingoddscalculator/constants.dart' as Constants;

import '../ad_state.dart';

class BestOddsCalculator extends StatefulWidget {
  const BestOddsCalculator({Key? key}) : super(key: key);

  @override
  State<BestOddsCalculator> createState() => _BestOddsCalculatorState();
}

class _BestOddsCalculatorState extends State<BestOddsCalculator> {
  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        _bannerAd = BannerAd(
          adUnitId: adState.bannerAdUnitTwo,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<SingleOddCalculationProvider>(context);
    var settingsProviderBloc = Provider.of<SettingsProvider>(context);
    var bestOddBloc = Provider.of<BestOddProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Constants.appBarLogo,
          title: Text(
            AppLocalizations.of(context)!.appTitle,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: "Info",
              onPressed: () {
                showHelpDialog(context);
              },
              icon: Icon(Icons.help_outline_rounded),
            ),
            //  ExitWidget(context),
          ],
          bottom: PreferredSize(
            child: BottomAppbarDecoration(),
            preferredSize: Size(MediaQuery.of(context).size.width, 20.0),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyCardContainer(
              preferedElevation: 6.0,
              topMargin: 0.0,
              // margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.winnerOdd,
                                    style: Constants.formHeadingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    //------------------
                                    bestOddBloc.bestValueOdd != null
                                        ? (() {
                                            if (settingsProviderBloc
                                                    .oddFormatSelection ==
                                                'decimal') {
                                              return "${bestOddBloc.bestValueOdd!.decimalOdd.toStringAsFixed(2)}";
                                            } else if (settingsProviderBloc
                                                    .oddFormatSelection ==
                                                'fraction') {
                                              return "${bestOddBloc.bestValueOdd!.numerator}/${bestOddBloc.bestValueOdd!.denominator}";
                                            } else {
                                              return "${bestOddBloc.bestValueOdd!.moneyLineOdd}";
                                            }
                                          })()
                                        : "   ",
                                    textAlign: TextAlign.center,
                                    style:
                                        Provider.of<SettingsProvider>(context)
                                                .darkModeSetting
                                            ? Constants.resultTextFieldFontStyle
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 20.0)
                                            : Constants.resultTextFieldFontStyle
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.bookie,
                                    style: Constants.formHeadingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    bestOddBloc.bestValueOdd != null
                                        ? "${bestOddBloc.bestValueOdd!.bookieName}"
                                        : "   ",
                                    textAlign: TextAlign.center,
                                    style: Provider.of<SettingsProvider>(
                                                context)
                                            .darkModeSetting
                                        ? Constants.resultTextFieldFontStyle
                                            .copyWith(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                          )
                                        : Constants.resultTextFieldFontStyle
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20.0,
                                                fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 32.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    thickness: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.impliedProbability,
                            textAlign: TextAlign.center,
                            style: Constants.resultHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            bestOddBloc.impliedProbability != null
                                ? "${bestOddBloc.impliedProbability!.toStringAsFixed(1)}%"
                                : "   ",
                            style: Constants.resultTextFieldFontStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.consensusProbabilityAcronym}",
                            textAlign: TextAlign.center,
                            style: Constants.resultHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            bestOddBloc.consensusProbability != 0
                                ? "${bestOddBloc.consensusProbability.toStringAsFixed(2)}"
                                : "   ",
                            style: Constants.resultTextFieldFontStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.expectedValue,
                            style: Constants.resultHeadingTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          (bestOddBloc.expectedValue != null)
                              ? FairValueSemaforo(
                                  expectedValue: bestOddBloc.expectedValue)
                              : Icon(
                                  Icons.circle,
                                  size: 20.0,
                                  color: Colors.transparent,
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                //  elevation: 6.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),

                /*   color: Provider.of<SettingsProvider>(context).darkModeSetting
                    ? null
                    : Colors.grey[100], */
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: ListView.builder(
                  //   padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),

                  itemCount: bestOddBloc.bettingOddList.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        bestOddBloc.removeOdd(index);
                      },
                      background: DismissibleBackgroundContainer(
                          backgroundType: BackgroundType.Delete),
                      key: UniqueKey(),
                      child: Card(
                        //  elevation: 8.0,
                        margin: EdgeInsets.only(bottom: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.0,
                              ),
                              gradient: Provider.of<SettingsProvider>(context)
                                      .darkModeSetting
                                  ? null
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white,
                                        Theme.of(context).primaryColor,
                                      ],
                                      stops: [
                                        0.6,
                                        0.8,
                                      ],
                                    )),
                          child: ListTile(
                            tileColor: Colors.transparent,
                            leading: Container(
                              height: MediaQuery.of(context).size.height,
                              child: FairValueSemaforo(
                                  expectedValue: Utility.calculateExpectedValue(
                                      bet: 1.0,
                                      decimalOdd: bestOddBloc
                                          .bettingOddList[index].decimalOdd,
                                      probability: 1 /
                                          bestOddBloc.bettingOddList[index]
                                              .decimalOdd)),
                            ),
                            subtitle: Text(
                              "${bestOddBloc.bettingOddList[index].bookieName}",
                              style:
                                  Constants.resultTextFieldFontStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            title: Text(
                              (() {
                                if (settingsProviderBloc.oddFormatSelection ==
                                    'decimal') {
                                  return "${bestOddBloc.bettingOddList[index].decimalOdd.toStringAsFixed(2)}";
                                } else if (settingsProviderBloc
                                        .oddFormatSelection ==
                                    'fraction') {
                                  return "${bestOddBloc.bettingOddList[index].numerator}/${bestOddBloc.bettingOddList[index].denominator}";
                                } else {
                                  return "${bestOddBloc.bettingOddList[index].moneyLineOdd}";
                                }
                              })(),
                              style: Provider.of<SettingsProvider>(context)
                                      .darkModeSetting
                                  ? Constants.resultTextFieldFontStyle.copyWith(
                                      color: Colors.white, fontSize: 16.0)
                                  : Constants.resultTextFieldFontStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0),
                            ),
                            trailing: Text(
                              "${Utility.calculateImpliedProbability(bestOddBloc.bettingOddList[index].decimalOdd)!.toStringAsFixed(1)}%",
                              style:
                                  Constants.resultTextFieldFontStyle.copyWith(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (_bannerAd == null)
              SizedBox(
                height: 50,
              )
            else
              Container(
                height: 50,
                child: AdWidget(ad: _bannerAd!),
                margin: EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                ),
              ),

            /// ------------------
            // BOTTOM BUTTON BAR ( X CLEAR Z ADD ODD)
            // -------------------
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      icon: Icon(Icons.cancel),
                      label: Text(
                          AppLocalizations.of(context)!.reset.toUpperCase()),
                      elevation: 10.0,
                      backgroundColor: Color(0xFFB71C1C),
                      onPressed: () {
                        bestOddBloc.clearList();
                        bestOddBloc.clearResultDashboard();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: MyElevatedButton(
                      elevation: 10.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        bestOddBloc.tecBookieName.clear();
                        bloc.clearTextFieldControllers();
                        // ===============================
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              //  height: MediaQuery.of(context).size.height,
                              margin: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      (() {
                                        if (settingsProviderBloc
                                                .oddFormatSelection ==
                                            'decimal') {
                                          return " ${AppLocalizations.of(context)!.decimal.toUpperCase()} ";
                                        } else if (settingsProviderBloc
                                                .oddFormatSelection ==
                                            'fraction') {
                                          return " ${AppLocalizations.of(context)!.fraction.toUpperCase()} ";
                                        } else {
                                          return " ${AppLocalizations.of(context)!.american.toUpperCase()} ";
                                        }
                                      })(),
                                      style: Constants.formHeadingTextStyle
                                          .copyWith(
                                        color: Colors.red,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .enterBookieName,
                                    style: Constants.formHeadingTextStyle,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      enabled: true,
                                      controller: bestOddBloc.tecBookieName,
                                      keyboardType: TextInputType.text,
                                      maxLength: 16,
                                      decoration:
                                          Provider.of<SettingsProvider>(context)
                                                  .darkModeSetting
                                              ? Constants
                                                  .getTextFieldDarkDecoration(
                                                      context)
                                              : Constants
                                                  .getTextFieldLightDecoration(
                                                      context),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.enterOdd,
                                    style: Constants.formHeadingTextStyle,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: Provider.of<SettingsProvider>(
                                                    context)
                                                .oddFormatSelection ==
                                            'fraction'
                                        ? FractionFormatTextField(bloc: bloc)
                                        : DecimalAmericanFormatTextField(
                                            bloc: bloc),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          bestOddBloc.tecBookieName.clear();
                                          bloc.clearTextFieldControllers();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .cancel
                                              .toUpperCase(),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          switch (settingsProviderBloc
                                              .oddFormatSelection) {
                                            case 'decimal':
                                              bloc.doCalculation(
                                                  bloc.oddTextFieldController
                                                      .text,
                                                  "");
                                              addOddToList(bestOddBloc, bloc);
                                              break;
                                            case 'american':
                                              bloc.doCalculationAmerican(
                                                  bloc.oddTextFieldController
                                                      .text,
                                                  "");
                                              addOddToList(bestOddBloc, bloc);
                                              break;
                                            case 'fraction':
                                              bloc.doCalculationFraction(
                                                  bloc.oddTextFieldController
                                                      .text,
                                                  bloc.oddTextFieldDenominatorController
                                                      .text,
                                                  "");
                                              addOddToList(bestOddBloc, bloc);
                                              break;
                                            default:
                                          }
                                          bestOddBloc.getWinnerOdd();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .add
                                                .toUpperCase()),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.calculate),
                      label: Text(
                          AppLocalizations.of(context)!.enterOdd.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addOddToList(
      BestOddProvider bestOddBloc, SingleOddCalculationProvider bloc) {
    if (!Utility.isBlankString(bestOddBloc.tecBookieName.text) &&
        bloc.bettingOdd != null) {
      bloc.bettingOdd!.bookieName = bestOddBloc.tecBookieName.text;
      bestOddBloc.addOdd(bloc.bettingOdd!);
      bestOddBloc.tecBookieName.clear();
      bloc.clearTextFieldControllers();
    }
  }
}

Future<void> showHelpDialog(context) {
  return showGeneralDialog(
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
              AppLocalizations.of(context)!.help,
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            children: [
              ListBody(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.bestOddHelpDialog,
                    textAlign: TextAlign.justify,
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
}
