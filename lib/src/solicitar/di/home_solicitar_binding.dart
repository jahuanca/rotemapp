
import 'package:app_metor/src/solicitar/data/datastores/solicitar/solicitar_datastore_implementation.dart';
import 'package:app_metor/src/solicitar/data/repositories/solicitar_repository_implementation.dart';
import 'package:app_metor/src/solicitar/domain/datastores/solicitar_datastore.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/get_solicitudes_use_case.dart';
import 'package:app_metor/src/solicitar/ui/pages/home_solicitar/home_solicitar_controller.dart';
import 'package:get/get.dart';

class HomeSolicitarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SolicitarDatastore>(() => SolicitarDatastoreImplementation());

    Get.lazyPut<SolicitarRepository>(
        () => SolicitarRepositoryImplementation(datastore: Get.find()));
    
    Get.lazyPut<GetSolicitudesUseCase>(
        () => GetSolicitudesUseCase(repository: Get.find()));

    Get.lazyPut<HomeSolicitarController>(() => HomeSolicitarController(
        getSolicitudesUseCase: Get.find(),
      ),
    ); 
  }
}