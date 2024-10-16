import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:get/get.dart';

class DetailSolicitudController extends GetxController {
  bool showButton = false;
  PendienteEntity? solicitud;

  DetailSolicitudController();

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[pendienteEntityArgument] != null){
       solicitud =  Get.arguments[pendienteEntityArgument] as PendienteEntity;
      }
    }
    super.onInit();
  }


}
