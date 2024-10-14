
import 'package:app_metor/src/home/di/main_content_binding.dart';
import 'package:app_metor/src/home/ui/pages/main_content/main_content.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/login/di/login_binding.dart';
import 'package:app_metor/src/login/ui/pages/login/login_page.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

SplashController();

  @override
  void onReady() {
    goTo();
    super.onReady();
  }

  Future<void> goTo() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      UserPreferences userPreferences = UserPreferences();
      if(userPreferences.getBool(isActiveKey)){
        Get.off(()=> const MainContent(), binding: MainContentBinding());
      }else{
        Get.off(()=> const LoginPage(), binding: LoginBinding());
      }
    },);
  }

}