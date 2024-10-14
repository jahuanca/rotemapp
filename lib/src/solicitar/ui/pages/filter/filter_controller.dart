import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  double minMontoToFilter = 0;
  List<String> status = [];
  

  void onChangedMonto(double value) {
    minMontoToFilter = value;
    update([montoMinId]);
  }

  void onChangedAllStates(bool? value) {
    if (value ?? false) {
      status.clear();
      status.addAll([codeCompleta, codePendiente, codeRechazada]);
    } else {
      status.clear();
    }
    update([allStatesId]);
  }

  void onChangeState(bool? value, String code) {
    if (value ?? false) {
      status.add(code);
    } else {
      status.remove(code);
    }
    update([allStatesId]);
  }

}
