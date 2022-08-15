class BettingOdd {
  String? bookieName;
  int? numerator;
  int? denominator;
  int? _moneyLine;
  double _decimalOdd = 0.0;

  BettingOdd.decimal({required double decimalNumber}) {
    if (decimalNumber >= 1.0) {
      this._decimalOdd = decimalNumber;
      this._moneyLine = getDecimalToMoneyLine(_decimalOdd);
      convertDecimalToFraction(_decimalOdd);
    } else {
      throw Exception('Illegal argument exception');
    }
    assert(decimalNumber >= 1.0);
  }

  BettingOdd.american(int number) {
    if (number >= 100 || number <= -100) {
      if (number >= 100) {
        _moneyLine = number;
        this._decimalOdd = (number / 100) + 1.0;
        convertDecimalToFraction(_decimalOdd);
        print("American format: $number");
        print("Decimal odd is: $_decimalOdd");
      }
      if (number <= -100) {
        _moneyLine = number;
        _decimalOdd = (100 / number.abs()) + 1.0;
        convertDecimalToFraction(_decimalOdd);
        print("American format: $number");
        print("Decimal odd is: $_decimalOdd");
      }
    } else {
      throw Exception('Illegal argument exception');
    }
    assert(number >= 100 || number <= -100);
  }

  BettingOdd.fraction({required int numerator, required int denominator}) {
    if (numerator >= 1 && denominator >= 1) {
      this.numerator = numerator;
      this.denominator = denominator;
      this._decimalOdd = (numerator / denominator) + 1.0;
      this._moneyLine = getDecimalToMoneyLine(_decimalOdd);
      print("Fraction format: $numerator/$denominator");
      print("Decimal odd is: $_decimalOdd");
    } else {
      throw Exception('Illegal argument exception');
    }
  }

  double get decimalOdd => _decimalOdd;
  int? get moneyLineOdd => _moneyLine;

  int? getDecimalToMoneyLine(double? decimalOdd) {
    if (decimalOdd! >= 2) {
      double? result = (decimalOdd - 1) * 100.0;
      return result.toInt();
    } else if (decimalOdd < 2) {
      double? result = -100.0 / (decimalOdd - 1);
      return result.toInt();
    } else {
      return null;
    }
  } //

  void convertDecimalToFraction(double decimalOdd) {
    this.denominator = 100;
    double tempNumerator = (decimalOdd * 100.0) - 100.0;
    this.numerator = tempNumerator.round().toInt();

    bool condicion = true;

    double tempNumerador;
    double tempDenominador;

    while (condicion) {
      if ((this.numerator! % 2) == 0 && (this.denominator! % 2) == 0) {
        tempNumerador = this.numerator! / 2;
        tempDenominador = this.denominator! / 2;
        this.numerator = tempNumerador.toInt();
        this.denominator = tempDenominador.toInt();
      } else if ((this.numerator! % 5) == 0 && (this.denominator! % 5) == 0) {
        tempNumerador = this.numerator! / 5;
        tempDenominador = this.denominator! / 5;
        this.numerator = tempNumerador.toInt();
        this.denominator = tempDenominador.toInt();
      } else {
        condicion = false; // end condition
      }
    } // // end while
  }
} //
