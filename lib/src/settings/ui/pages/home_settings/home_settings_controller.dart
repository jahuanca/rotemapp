
import 'package:app_metor/src/login/di/login_binding.dart';
import 'package:app_metor/src/login/ui/pages/login/login_page.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class HomeSettingsController extends GetxController{

  UserPreferences userPreferences = UserPreferences();

  Future<void> goCerrarSesion() async{
    bool? result = await showDialogWidget(
      context: Get.context!, 
      message: '¿Está seguro de cerrar sesión?');
    if(result == true){
      await userPreferences.clearAll();
      Get.offAll(const LoginPage(), binding: LoginBinding());
    }
  }


}