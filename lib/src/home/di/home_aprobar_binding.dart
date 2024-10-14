
import 'package:app_metor/src/home/data/aprobar/datastores/aprobar_datastore_implementation.dart';
import 'package:app_metor/src/home/data/aprobar/repositories/aprobar_repository_implementation.dart';
import 'package:app_metor/src/home/domain/aprobar/datastores/aprobar_datastore.dart';
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/home/domain/aprobar/use_cases/get_pedientes_aprobar_use_case.dart';
import 'package:app_metor/src/aprobar/ui/pages/home_aprobar/home_aprobar_controller.dart';
import 'package:get/get.dart';

class HomeAprobarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AprobarDatastore>(() => AprobarDatastoreImplementation());

    Get.lazyPut<AprobarRepository>(
        () => AprobarRepositoryImplementation(datastore: Get.find()));
    
    Get.lazyPut<GetPedientesAprobarUseCase>(
        () => GetPedientesAprobarUseCase(repository: Get.find()));

    Get.lazyPut<HomeAprobarController>(() => HomeAprobarController(
        getPedientesAprobarUseCase: Get.find(),
      ),
    );
  }
  
}