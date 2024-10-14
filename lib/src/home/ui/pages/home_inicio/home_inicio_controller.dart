
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:get/get.dart';

class HomeInicioController extends GetxController{

  late UserEntity userEntity;

  @override
  void onInit() {
    UserPreferences userPreferences = UserPreferences();
    String? user =userPreferences.getObjectString(userProfileKey);
    if(user != null) userEntity = userEntityFromJson( user );
    update([pageId]);
    super.onInit();
  }

}