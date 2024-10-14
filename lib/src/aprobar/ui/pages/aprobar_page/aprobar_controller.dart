
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:get/get.dart';

class AprobarController extends GetxController{

  List<PendienteEntity> pendientes = [];

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[pendientesArgument] != null){
        pendientes.addAll(
          Get.arguments[pendientesArgument] as List<PendienteEntity>
        );
        update([listadoId]);
      }
    }
    super.onInit();
  }




}