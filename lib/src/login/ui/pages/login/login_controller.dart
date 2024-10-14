
import 'package:app_metor/src/home/di/main_content_binding.dart';
import 'package:app_metor/src/home/ui/pages/main_content/main_content.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/login/domain/login/entities/login_entity.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/login/domain/login/use_cases/login_use_case.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class LoginController extends GetxController {
  String cedula = emptyString;
  String password = emptyString;

  String? errorCedula, errorPassword;

  LoginUseCase loginUseCase;

  bool validando = false;

  LoginController({
    required this.loginUseCase,
  });

  void onChangedCedula(String value) {
    errorCedula = validatorText(text: value, label: 'Cédula', rules: {
      RuleValidator.isRequired: true,
    });

    if (errorCedula == null) cedula = value;
    update([cedulaId]);
  }

  void onChangedPassword(String value) {
    errorPassword = validatorText(text: value, label: 'Contraseña', rules: {
      RuleValidator.isRequired: true,
    });

    if (errorPassword == null) password = value;
    update([passwordId]);
  }

  String? _validar() {
    onChangedCedula(cedula);
    onChangedPassword(password);

    if (errorCedula != null) return errorCedula;
    if (errorPassword != null) return errorPassword;
    return null;
  }

  void goLogin() async {
    String? mensaje = _validar();
    if (mensaje == null) {
      validando = true;
      update([pageId]);
      ResultType<UserEntity, ErrorEntity> result = await loginUseCase.execute(
        loginEntity: LoginEntity(cedula: cedula, password: password),
      );
      if(result is Success){
        UserEntity userEntity = result.data as UserEntity;
        UserPreferences userPreferences = UserPreferences();
        await userPreferences.setBool(isActiveKey, true);
        await userPreferences.setString(cedulaKey, userEntity.usuario);
        if(userEntity.detalleperfil.toLowerCase() == empleadoString.toLowerCase()){
          await userPreferences.setBool(isEmpleadoKey, true);
          await userPreferences.setBool(isAprobadorKey, false);
        }else{
          await userPreferences.setBool(isEmpleadoKey, false);
          await userPreferences.setBool(isAprobadorKey, true);
        }
        await userPreferences.setObjectString(userProfileKey, userEntity);
        Get.off(() => const MainContent(), binding: MainContentBinding());
      }else{
        showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: (result.error as ErrorEntity).message);
      }
      validando = false;
      update([pageId]);
    } else {
      showSnackbarWidget(
          context: Get.context!,
          typeSnackbar: TypeSnackbar.error,
          message: mensaje);
    }
  }
}
