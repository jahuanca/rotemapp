
import 'package:app_metor/src/solicitar/domain/use_cases/create_user_request_use_case.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/get_user_amounts_use_case.dart';
import 'package:app_metor/src/solicitar/ui/pages/nueva_solicitud/nueva_solicitud_controller.dart';
import 'package:get/get.dart';

class NuevaSolicitudBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetUserAmountsUseCase>(
        () => GetUserAmountsUseCase(repository: Get.find()));
    
    Get.lazyPut<CreateUserRequestUseCase>(
        () => CreateUserRequestUseCase(repository: Get.find()));

    Get.lazyPut<NuevaSolicitudController>(() => NuevaSolicitudController(
        getUserAmountsUseCase: Get.find(),
        createUserRequestUseCase: Get.find(),
      ),
    );
  }


}