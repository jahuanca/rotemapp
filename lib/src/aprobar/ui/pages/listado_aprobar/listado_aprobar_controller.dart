
import 'package:app_metor/src/aprobar/ui/pages/aprobar_page/aprobar_page.dart';
import 'package:app_metor/src/home/data/responses/manage_request_response.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/home/domain/aprobar/use_cases/manage_request_use_case.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/di/nueva_solicitud_binding.dart';
import 'package:app_metor/src/solicitar/ui/pages/nueva_solicitud/nueva_solicitud_page.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:app_metor/src/utils/ui/pages/results/results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class ListadoAprobarController extends GetxController{

  Map<String,List<PendienteEntity>> pendientes = {};
  Map<String,List<PendienteEntity>> pendientesMostradas = {};
  String valorBuscar = emptyString;
  TextEditingController valorBuscadoTextEditingController = TextEditingController();
  FocusNode focusValorBuscado = FocusNode();
  bool isSelectionView = false;
  List<PendienteEntity> selections = [];
  String concepto = emptyString;
  bool validando = false;
  ManageRequestUseCase manageRequestUseCase;

  ListadoAprobarController({
    required this.manageRequestUseCase,
  });

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
    valorBuscadoTextEditingController.text = emptyString;
    pendientesMostradas.addAll(pendientes);
    valorBuscar = emptyString;
    focusValorBuscado.unfocus();
    update([valorBuscadoId, listadoId]);
  }

  Future<void> goAprobar() async{
    bool? result = await showDialogWidget(context: Get.overlayContext!, message: _createContent(
      isReject: false
    ));
    if(result != null){
      crearSolicitud(isReject: false);
    }
  }

  Future<void> goRechazar() async {
    bool? result = await showDialogWidget(context: Get.overlayContext!, message: _createContent(
      isReject: true
    ));
    if(result != null){
      crearSolicitud(isReject: true);
    }
  }

  String _createContent({
    required bool isReject
  }){
    String content =  '¿Esta seguro de ';
    content += isReject ? 'rechazar' : 'aceptar';
    content+=" las siguientes solicitudes?";
    for (PendienteEntity selected in selections) {
      content+='\n S/ ${selected.importe} - ${selected.nomcomp}. ';
    }
    return content;
  }

  Future<void> crearSolicitud({
    required bool isReject,
  }) async {
    validando = true;
    update([validandoId]);
    List<ManageRequestResponse> requests = selections.map(
      (e) => ManageRequestResponse(
        id: e.id.toString(), 
        codigoestado: isReject ? 'R' : 'A',
        nombre: e.nomcomp,
        concepto: e.concepto,
        ),).toList();
    ResultType<List<CreateUserRequestResponse>, ErrorEntity> resultType =
        await manageRequestUseCase.execute(
      requests: requests,
    );
    if (resultType is Success) {
      List<CreateUserRequestResponse> results =
          resultType.data as List<CreateUserRequestResponse>;
      for (int i = 0; i < results.length; i++) {
        ManageRequestResponse request = requests
            .firstWhere(
              (e) => results[i].id.toString() == e.id,
            );
        results[i].amount = 
           (results[i].success == "0") ? request.nombre : request.nombre;
        results[i].detail = 
           (results[i].success == "0") ? request.concepto : request.concepto;
      }
      Get.off(() => const ResultsPage(), arguments: {
        responsesKey: results
      });
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: (resultType.error as ErrorEntity).message);
    }
    validando = false;
    update([validandoId]);
  }

}