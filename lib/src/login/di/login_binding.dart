import 'package:app_metor/src/login/data/login/datastores/login_datastore_implementation.dart';
import 'package:app_metor/src/login/data/login/repositories/login_repository_implementation.dart';
import 'package:app_metor/src/login/domain/login/datastores/login_datastore.dart';
import 'package:app_metor/src/login/domain/login/repositories/login_repository.dart';
import 'package:app_metor/src/login/domain/login/use_cases/login_use_case.dart';
import 'package:app_metor/src/login/ui/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginDatastore>(() => LoginDatastoreImplementation());

    Get.lazyPut<LoginRepository>(
        () => LoginRepositoryImplementation(datastore: Get.find()));
    
    Get.lazyPut<LoginUseCase>(
        () => LoginUseCase(repository: Get.find()));

    Get.lazyPut<LoginController>(() => LoginController(
        loginUseCase: Get.find(),
      ),
    );
  }
  
}
