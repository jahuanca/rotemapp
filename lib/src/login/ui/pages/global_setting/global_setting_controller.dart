
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:get/get.dart';

class GlobalSettingController extends GetxController{

  late UserPreferences userPreferences;
  bool isQas = false;

  @override
  void onInit() {
    userPreferences = UserPreferences();
    super.onInit();
  }

  void changeAmbiente(bool? value){
    isQas = value ?? false;
    update([ambienteId]);
  }



}