
import 'package:app_metor/src/aprobar/ui/pages/aprobar_page/aprobar_controller.dart';
import 'package:app_metor/src/home/data/aprobar/datastores/aprobar_datastore_implementation.dart';
import 'package:app_metor/src/home/data/aprobar/repositories/aprobar_repository_implementation.dart';
import 'package:app_metor/src/home/domain/aprobar/datastores/aprobar_datastore.dart';
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/home/domain/aprobar/use_cases/manage_request_use_case.dart';
import 'package:get/get.dart';

class AprobarBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<AprobarDatastore>(() => AprobarDatastoreImplementation());

    Get.lazyPut<AprobarRepository>(
        () => AprobarRepositoryImplementation(datastore: Get.find()));

    Get.lazyPut<ManageRequestUseCase>(
        () => ManageRequestUseCase(repository: Get.find()));

    Get.lazyPut<AprobarController>(() => AprobarController(
      manageRequestUseCase: Get.find(),
    ),
  ); 
  }
}