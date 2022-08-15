import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlossaryProvider extends ChangeNotifier{

    List<bool> expansionPanelStateList = <bool>[
      false,
      false,
      false,
      false,
      false,
      false,
    ];


    GlossaryProvider();

    changeState(int index, bool isExpanded){
        expansionPanelStateList[index] = isExpanded;
        notifyListeners();
    }

}