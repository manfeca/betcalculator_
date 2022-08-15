class Utility {
// Return true is string is blank
  static bool isBlankString(String? value) {
    return (value == null || value.trim().isEmpty);
  }

  // =================================================
  // Calculate the implied probability of a given odd
  // ==================================================
  static double? calculateImpliedProbability(double decimalOdd) {
    if (decimalOdd >= 1.0) {
      double impliedProbability = (1 / decimalOdd) * 100.0;
      return impliedProbability;
    } else {
      return null;
    }
  }

// ======================================
// Calculate the expected value of an odd
// ======================================
  static double? calculateExpectedValue(
      {required double bet,
      required double decimalOdd,
      required double probability}) {
    if (bet > 0 &&
        decimalOdd > 1.0 &&
        probability > 0.0 &&
        probability <= 1.0) {
      String probabilityFirstOperand =
          (probability * 100.0).round().toStringAsFixed(0);
      String probabilitySecondOperand =
          (100.0 - (probability * 100).round()).toStringAsFixed(0);
      print("Probability $probabilityFirstOperand");
      print("Probability $probabilitySecondOperand");

      double firstProb = double.parse(probabilityFirstOperand) / 100;
      double secondProb = double.parse(probabilitySecondOperand) / 100;
      print(firstProb);
      print(secondProb);
      double result =
          (((bet * decimalOdd) - bet) * firstProb) - (bet * secondProb);
      print("Resultado : $result");
      return result;
    } else {
      return null;
    }
  } //

}
