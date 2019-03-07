

import 'package:flutter_app/BLoc/BLoc.dart';
import 'package:rxdart/rxdart.dart';

class RootAppBloc extends BLoc{

  BehaviorSubject<bool> phoneNumberWidget = BehaviorSubject<bool>()..add(false


  );

  Observable<bool> get phoneNumberWidgetStream => phoneNumberWidget.stream;



  @override
  void dispose() {
    phoneNumberWidget.close();
  }
}
RootAppBloc bloc ;