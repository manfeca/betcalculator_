import 'package:bettingoddscalculator/blocs/settings_provider.dart';
import 'package:bettingoddscalculator/blocs/single_odd_calc_provider.dart';
import 'package:bettingoddscalculator/widgets/buttons/my_elevated_button.dart';
import 'package:bettingoddscalculator/widgets/decimal_american_format_textfield.dart';
import 'package:bettingoddscalculator/widgets/decoration/bottom_appbar_decoration.dart';
import 'package:bettingoddscalculator/widgets/fairvalue_semaforo.dart';
import 'package:bettingoddscalculator/widgets/fraction_format_textfield.dart';
import 'package:bettingoddscalculator/widgets/my_card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../ad_state.dart';
import '../constants.dart' as Constants;

class SingleOddCalculationScreen extends StatefulWidget {
  const SingleOddCalculationScreen({Key? key}) : super(key: key);

  @override
  State<SingleOddCalculationScreen> createState() =>
      _SingleOddCalculationScreenState();
}

class _SingleOddCalculationScreenState
    extends State<SingleOddCalculationScreen> {
  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        _bannerAd = BannerAd(
          adUnitId: adState.bannerAdUnitOne,
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

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Constants.appBarLogo,
        title: Text(AppLocalizations.of(context)!.appTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          //  ExitWidget(context),
        ],
        bottom: PreferredSize(
          child: BottomAppbarDecoration(),
          preferredSize: Size(MediaQuery.of(context).size.width, 20.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCardContainer(
                    preferedElevation: 6.0,
                    topMargin: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          alignment: Alignment.topRight,
                          child: Text(
                            (() {
                              if (settingsProviderBloc.oddFormatSelection ==
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
                            style: Constants.formHeadingTextStyle.copyWith(
                              color: Colors.red,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            AppLocalizations.of(context)!.odd,
                            textAlign: TextAlign.left,
                            style: Constants.formHeadingTextStyle,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: settingsProviderBloc.oddFormatSelection ==
                                  'fraction'
                              ? FractionFormatTextField(bloc: bloc)
                              : DecimalAmericanFormatTextField(bloc: bloc),
                        ),

                        // ENTER BED TEXTFIELD
                        // ====================
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            AppLocalizations.of(context)!.bet,
                            textAlign: TextAlign.left,
                            style: Constants.formHeadingTextStyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 8.0,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: TextField(
                            controller: bloc.betTextFieldController,
                            autocorrect: true,
                            onSubmitted: (value) {
                              //  bloc.doCalculation(value);
                            },
                            autofocus: false,
                            style: Constants.textFieldFontStyle,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            showCursor: true,
                            enableInteractiveSelection: true,
                            // autofocus: true,
                            decoration: Provider.of<SettingsProvider>(context)
                                    .darkModeSetting
                                ? Constants.getTextFieldDarkDecoration(context)
                                : Constants.getTextFieldLightDecoration(
                                    context),
                          ),
                        ),
                        // ===================//
                        /* Divider(
                          height: 16.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          thickness: 1.0,
                          color: Theme.of(context).primaryColor,
                        ),*/
                      ],
                    ),
                    bottomMargin: 4.0,
                  ),
                  MyCardContainer(
                    topMargin: 4.0,
                    bottomMargin: 8.0,
                    preferedElevation: 6.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .impliedProbability,
                                textAlign: TextAlign.center,
                                style: Constants.resultHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity:
                                    bloc.isImpliedContainerAnimated ? 1.0 : 0.0,
                                child: Text(
                                  bloc.impliedProbability != null
                                      ? "${bloc.impliedProbability!.toStringAsFixed(1)}%"
                                      : " ",
                                  style: Constants.resultTextFieldFontStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.profit}\n",
                                textAlign: TextAlign.center,
                                style: Constants.resultHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity:
                                    bloc.isResultDashboardAnimated ? 1.0 : 0.0,
                                child: Text(
                                  bloc.profit != null
                                      ? bloc.profit!.toStringAsFixed(1)
                                      : " ",
                                  style: Constants.resultTextFieldFontStyle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ==================
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.totalProfit}\n",
                                textAlign: TextAlign.center,
                                style: Constants.resultHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity:
                                    bloc.isResultDashboardAnimated ? 1.0 : 0.0,
                                child: Container(
                                  child: Text(
                                      bloc.yourTotalReturn != null
                                          ? bloc.yourTotalReturn!
                                              .toStringAsFixed(1)
                                          : " ",
                                      style:
                                          Constants.resultTextFieldFontStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // =================

                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.expectedValue}",
                                style: Constants.resultHeadingTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity:
                                    bloc.isResultDashboardAnimated ? 1.0 : 0.0,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: (bloc.expectedValue != null)
                                      ? FairValueSemaforo(
                                          expectedValue: bloc.expectedValue)
                                      : Icon(
                                          Icons.circle,
                                          size: 20.0,
                                          color: Colors.transparent,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ============ BUTTON BAR ===============

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyElevatedButton(
                          icon: Icon(Icons.calculate),
                          label: Text(AppLocalizations.of(context)!
                              .convert
                              .toUpperCase()),
                          fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 42.0)),
                          elevation: 10.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            bloc.clearFields();
                            switch (settingsProviderBloc.oddFormatSelection) {
                              case 'decimal':
                                bloc.doCalculation(
                                    bloc.oddTextFieldController.text,
                                    bloc.betTextFieldController.text);
                                break;
                              case 'american':
                                bloc.doCalculationAmerican(
                                    bloc.oddTextFieldController.text,
                                    bloc.betTextFieldController.text);
                                break;
                              case 'fraction':
                                bloc.doCalculationFraction(
                                    bloc.oddTextFieldController.text,
                                    bloc.oddTextFieldDenominatorController.text,
                                    bloc.betTextFieldController.text);
                                break;
                              default:
                            }
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        MyElevatedButton(
                          fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 42.0),
                          ),
                          elevation: 10.0,
                          backgroundColor: Color(0xFFB71C1C),
                          onPressed: () {
                            bloc.clearTextFieldControllers();
                          },
                          icon: Icon(Icons.cancel),
                          label: Text(AppLocalizations.of(context)!
                              .reset
                              .toUpperCase()),
                        ),
                      ],
                    ),
                  ),
                ],
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
        ],
      ),
    ));
  }
}
