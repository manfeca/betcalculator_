// ===================================================
// PROVIDER CONTROLLING THE BEST ODD CALCULATOR SCREEN
// ===================================================

import 'package:bettingoddscalculator/models/betting_odd.dart';
import 'package:bettingoddscalculator/resources/utility.dart';
import 'package:flutter/cupertino.dart';

class BestOddProvider extends ChangeNotifier {
  double consensusProbability = 0.0;
  BettingOdd? bestValueOdd;
  double? fairValue;
  double? expectedValue;
  double? impliedProbability;

  late List<BettingOdd> bettingOddList; // Hold the list of odds

  TextEditingController tecBookieName =
      new TextEditingController(); // Ccontrol the bookie textfield

  // Constructor
  BestOddProvider() {
    bettingOddList = List<BettingOdd>.empty(growable: true);
  }

  // Add odd to the ListView
  void addOdd(BettingOdd object) {
    bettingOddList.add(object);

    notifyListeners();
  }

  // Remove object from list
  void removeOdd(int index) {
    if (bettingOddList.isNotEmpty) {
      bettingOddList.removeAt(index);
    }
    if (bettingOddList.length < 3) {
      clearResultDashboard();
    } else {
      getWinnerOdd();
    }

    notifyListeners();
  }

  // Get the best value odd
  void getWinnerOdd() {
    double accumulator = 0;
    // Check list length is at least 3
    if (bettingOddList.length >= 3) {
      // === Calculate consensus probability or media
      bettingOddList.forEach((element) {
        accumulator += element.decimalOdd;
      });
      consensusProbability = 1 / (accumulator / bettingOddList.length);
      // =================================---------------

      print("Acumulador $accumulator");
      print("Divided by ${bettingOddList.length}");
      print("Cons. prob: ${consensusProbability.toStringAsFixed(2)}%");

      // ========== Find fair value ===================
      fairValue = 1 / (consensusProbability);

      // Find the best odd in the list
      bestValueOdd = bettingOddList.first; // ADD FIRST IN THE LIST
      bettingOddList.forEach((element) {
        if (element.decimalOdd > bestValueOdd!.decimalOdd) {
          bestValueOdd = element; // BEST VALUE ODD RESULT
        }
      });

      impliedProbability =
          Utility.calculateImpliedProbability(bestValueOdd!.decimalOdd);
      // Calculate expected value
      expectedValue = Utility.calculateExpectedValue(
          bet: 1.0,
          probability: consensusProbability,
          decimalOdd: bestValueOdd!.decimalOdd);
    } // end if

    notifyListeners();
  }

  // Clears the list to allow another calculation
  void clearList() {
    if (bettingOddList.isNotEmpty) {
      bettingOddList.clear();
    }

    notifyListeners();
  }

  // Clear the results
  void clearResultDashboard() {
    consensusProbability = 0;
    fairValue = null;
    bestValueOdd = null;
    expectedValue = null;
    impliedProbability = null;

    notifyListeners();
  }

  @override
  void dispose() {
    tecBookieName.dispose();
    super.dispose();
  }
}
