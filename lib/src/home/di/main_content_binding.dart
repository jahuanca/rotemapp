
import 'package:app_metor/src/home/di/home_aprobar_binding.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/di/home_solicitar_binding.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:get/get.dart';

class MainContentBinding extends Bindings{
  @override
  void dependencies() {
    UserPreferences userPreferences= UserPreferences();
    if(userPreferences.getBool(isEmpleadoKey)){
      HomeSolicitarBinding().dependencies();
    }else{
      HomeAprobarBinding().dependencies();
    }
    
  }


}