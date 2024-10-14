
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/di/nueva_solicitud_binding.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/get_solicitudes_use_case.dart';
import 'package:app_metor/src/solicitar/ui/pages/detail_solicitud/detail_solicitud_page.dart';
import 'package:app_metor/src/solicitar/ui/pages/filter/filter_page.dart';
import 'package:app_metor/src/solicitar/ui/pages/nueva_solicitud/nueva_solicitud_page.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSolicitarController extends GetxController{

  bool sentFromApprovePage = false;
  List<PendienteEntity> pendientes = [];
  List<PendienteEntity> pendientesMostradas = [];
  String valorBuscar = emptyString;
  TextEditingController valorBuscadoTextEditingController = TextEditingController();
  FocusNode focusValorBuscado = FocusNode();

  GetSolicitudesUseCase getSolicitudesUseCase;

  HomeSolicitarController({
    required this.getSolicitudesUseCase,
  });


  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[pendientesArgument] != null){
        sentFromApprovePage = true;
        pendientes.addAll(Get.arguments[pendientesArgument] as List<PendienteEntity>);
        pendientesMostradas.addAll(pendientes);
      }else{
      }
    }else{
      getSolicitudes();
    }
    super.onInit();
  }

  Future<void> getSolicitudes() async{
    String? cedula = UserPreferences().getString(cedulaKey);
    if( cedula != null ){
      ResultType<List<PendienteEntity>, ErrorEntity> result = await getSolicitudesUseCase.execute(cedula: cedula);
      if(result is Success){
        pendientes.clear();
        pendientesMostradas.clear();
        pendientes.addAll(result.data as List<PendienteEntity>);
        pendientesMostradas.addAll(pendientes);
      }
    }
    update([listadoId]);
  }
  
  void goAddSolicitud(){
    Get.to(
      ()=> NuevaSolicitudPage(), 
      binding: NuevaSolicitudBinding()
    );
  }

  void goDetailSolicitud(int index){
    Get.to(()=> const DetailSolicitudPage(), arguments: {
      sentFromApprovePageParameter: sentFromApprovePage,
      pendienteEntityArgument: pendientes[index]
    });
  }

  void goFilters(){
    Get.to(()=> const FilterPage());
  }

  void onChangedValorBuscar(String value){
    valorBuscar = value;
    pendientesMostradas.clear();
    pendientesMostradas.addAll(
      pendientes.where(
        (e) => e.nomcomp?.toLowerCase().contains(valorBuscar.toLowerCase()) ?? false
      )
    );
    update([valorBuscadoId, listadoId]);
  }

  void clearValorBuscado(){
    valorBuscadoTextEditingController.text = "";
    pendientesMostradas.addAll(pendientes);
    valorBuscar = "";
    focusValorBuscado.unfocus();
    update([valorBuscadoId, listadoId]);
  }

}