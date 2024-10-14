
import 'package:app_metor/src/aprobar/ui/pages/listado_aprobar/listado_aprobar_controller.dart';
import 'package:get/get.dart';

class ListadoAprobarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ListadoAprobarController>(() => ListadoAprobarController(),
  ); 
  }
}