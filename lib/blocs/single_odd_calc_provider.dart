// -----------------------------------------------------
// PROVIDER CONTROLLING THE SINGLE ODD CALCULATOR SCREEN
// -----------------------------------------------------

import 'package:bettingoddscalculator/models/betting_odd.dart';
import 'package:bettingoddscalculator/resources/utility.dart';
import 'package:flutter/cupertino.dart';

class SingleOddCalculationProvider extends ChangeNotifier {
  late BettingOdd? bettingOdd; // Hold the odd
  double? profit;
  double? yourTotalReturn;
  double? impliedProbability;
  double? expectedValue;

  bool isImpliedContainerAnimated =
      false; // Command the animation result display
  bool isResultDashboardAnimated =
      false; // Command the animation result display

  // ======= INPUT TEXT CONTROLLERS ====================== //
  TextEditingController oddTextFieldController = TextEditingController();
  TextEditingController oddTextFieldDenominatorController =
      TextEditingController();
  TextEditingController betTextFieldController = TextEditingController();

  // ====== OUTPUT TEXT CONTROLLERS ======================= //
  //TextEditingController impliedProbabilityTextFieldController =
  //  TextEditingController();

  SingleOddCalculationProvider() {
    oddTextFieldController.clear();
    oddTextFieldDenominatorController.clear();
    betTextFieldController.clear();
  }

  // Calculate for decimal odd
  doCalculation(String odd, String bet) {
    var tempOdd;

    try {
      tempOdd = double.parse(odd);

      if (tempOdd >= 1) {
        // Calculate implied probability
        bettingOdd = new BettingOdd.decimal(decimalNumber: tempOdd);
        isImpliedContainerAnimated = true;
        impliedProbability =
            Utility.calculateImpliedProbability(bettingOdd!.decimalOdd);

        notifyListeners();

        _calculateBet(bettingOdd!.decimalOdd, bet);
      } else {
        clearTextFieldControllers();
        bettingOdd = null;
        print("Value must be greater than 1!");
      }
    } on FormatException {
      print("Format exception caught!");
      clearTextFieldControllers();
      bettingOdd = null;
    }
    //  _calculateBet(tempOdd, bet);
    notifyListeners();
  }

  // Clear all textfields in the ui
  clearTextFieldControllers() {
    oddTextFieldController.clear();
    oddTextFieldDenominatorController.clear();
    betTextFieldController.clear();
    clearFields();
    notifyListeners();
  }

  clearFields() {
    isImpliedContainerAnimated = false;
    isResultDashboardAnimated = false;
    bettingOdd = null;
    impliedProbability = null;
    profit = null;
    yourTotalReturn = null;
    expectedValue = null;
    notifyListeners();
  }

  // Calculate profit if bet is entered
  void _calculateBet(double decimalOdd, String bet) {
    double? tempBet;
    //double? yourReturn;
    //double? yourTotalReturn;
    try {
      tempBet = double.parse(bet);
      if (tempBet > 0) {
        yourTotalReturn = (tempBet * decimalOdd);
        profit = (tempBet * decimalOdd) - tempBet;
        // yourReturnTextEditingController.text = profit.toStringAsFixed(2);
        //     yourTotalReturnTextEditingController.text =
        //        yourTotalReturn.toStringAsFixed(2);
        expectedValue = Utility.calculateExpectedValue(
            bet: tempBet,
            decimalOdd: decimalOdd,
            probability: 1.0 / decimalOdd);
        print("Expected value: $expectedValue");
        isResultDashboardAnimated = true;
        notifyListeners();
      } else {
        expectedValue = null;
        yourTotalReturn = null;
        profit = null;
        betTextFieldController.clear();
      }
    } on Exception {
      print("Bet is null or not valid");
      isResultDashboardAnimated = false;
      // clearFields();
    }
  }

  // Calculate if odd in american format
  void doCalculationAmerican(String odd, String bet) {
    int tempOdd;

    try {
      tempOdd = int.parse(odd);

      print("int parse = $tempOdd");
      if (tempOdd >= 100 || tempOdd <= -100) {
        bettingOdd = new BettingOdd.american(tempOdd);

        impliedProbability =
            Utility.calculateImpliedProbability(bettingOdd!.decimalOdd);

        isImpliedContainerAnimated = true;

        notifyListeners();
        _calculateBet(bettingOdd!.decimalOdd, bet);
      } else {
        clearTextFieldControllers();
        bettingOdd = null;
        print("Wrong format entered!");
      }
    } on FormatException {
      print("(american) Format exception caught!");
      clearTextFieldControllers();
      bettingOdd = null;
    }
    notifyListeners();
  } //

  // Calculate if odd in fraction format
  void doCalculationFraction(
      String numeratorOdd, String denominatorOdd, String bet) {
    int tempNumeratorOdd;
    int tempDenominatorOdd;

    try {
      tempNumeratorOdd = int.parse(numeratorOdd);
      tempDenominatorOdd = int.parse(denominatorOdd);

      print("fraction parse: $tempNumeratorOdd/$tempDenominatorOdd");

      if (tempDenominatorOdd >= 1 && tempDenominatorOdd >= 1) {
        bettingOdd = new BettingOdd.fraction(
            numerator: tempNumeratorOdd, denominator: tempDenominatorOdd);

        isImpliedContainerAnimated = true;

        impliedProbability =
            Utility.calculateImpliedProbability(bettingOdd!.decimalOdd);

        notifyListeners();
        _calculateBet(bettingOdd!.decimalOdd, bet);
      } else {
        clearTextFieldControllers();
        bettingOdd = null;
        print("Wrong format entered!");
      }
    } on FormatException {
      print("(fraction) Format exception caught!");
      clearTextFieldControllers();
      bettingOdd = null;
    }
  } //

  // dispolse() won't be called anyway
  @override
  void dispose() {
    super.dispose();
    oddTextFieldController.dispose();
    oddTextFieldDenominatorController.dispose();
    betTextFieldController.dispose();
  }
}
