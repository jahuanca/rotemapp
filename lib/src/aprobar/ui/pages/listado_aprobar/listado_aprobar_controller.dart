
import 'package:app_metor/src/aprobar/ui/pages/aprobar_page/aprobar_page.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/di/nueva_solicitud_binding.dart';
import 'package:app_metor/src/solicitar/ui/pages/nueva_solicitud/nueva_solicitud_page.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListadoAprobarController extends GetxController{

  Map<String,List<PendienteEntity>> pendientes = {};
  Map<String,List<PendienteEntity>> pendientesMostradas = {};
  String valorBuscar = emptyString;
  TextEditingController valorBuscadoTextEditingController = TextEditingController();
  FocusNode focusValorBuscado = FocusNode();
  bool isSelectionView = false;
  List<PendienteEntity> selections = [];
  String concepto = emptyString;

  ListadoAprobarController();


  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[groupByUsersArgument] != null){
        pendientes.addAll(Get.arguments[groupByUsersArgument] as Map<String,List<PendienteEntity>>);
        pendientesMostradas.addAll(pendientes);
      }else{
      }
      if(Get.arguments[conceptArgument] != null){
        concepto = Get.arguments[conceptArgument] as String;
      }
    }else{}
    super.onInit();
  }
  
  void goAddSolicitud(){
    Get.to(
      ()=> NuevaSolicitudPage(), 
      binding: NuevaSolicitudBinding()
    );
  }

  void goDetailSolicitud(List<PendienteEntity> pendientesByUser){
    Get.to(()=> const AprobarPage(), arguments: {
      pendientesArgument: pendientesByUser
    });
  }

  void changeSelectionView(){
    selections.clear();
    isSelectionView = !isSelectionView;
    update([pageId]);
  }

  void onChangeSelection(List<PendienteEntity> pendientes, bool? value){
    if(value ?? false){
      selections.addAll(
        pendientes
      );
    }
    else{
      selections.removeWhere((element) => element.nomcomp == pendientes.first.nomcomp,);
    }
    update([pageId]);
  }

  void onChangedValorBuscar(String value){
    valorBuscar = value;
    pendientesMostradas.clear();
    for (int i = 0; i < pendientes.values.length; i++) {
      String key = pendientes.keys.elementAt(i);
      List<PendienteEntity> pendienteByUser = pendientes[key]?.toList() ?? [];
      if(pendienteByUser.any(
        (e)=> e.nomcomp?.toLowerCase().contains(valorBuscar.toLowerCase()) ?? false)
      ){
        pendientesMostradas[key] = pendienteByUser;
      }
    } 
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