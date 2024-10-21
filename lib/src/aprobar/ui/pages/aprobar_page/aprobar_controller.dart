
import 'package:app_metor/src/aprobar/ui/pages/home_aprobar/home_aprobar_controller.dart';
import 'package:app_metor/src/home/data/responses/manage_request_response.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/home/domain/aprobar/use_cases/manage_request_use_case.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:app_metor/src/utils/ui/pages/results/results_page.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class AprobarController extends GetxController{

  List<PendienteEntity> pendientes = [];
  ManageRequestUseCase manageRequestUseCase;
  bool validando = true;

  AprobarController({
    required this.manageRequestUseCase,
  });

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[pendientesArgument] != null){
        pendientes.clear();
        pendientes.addAll(
          Get.arguments[pendientesArgument] as List<PendienteEntity>
        );
        update([listadoId]);
      }
    }
    super.onInit();
  }

  void onChangePendiente(val, int index){
    pendientes[index].isAccepted = val;
    update([listadoId, seleccionadosId]);
  }

  Future<void> goSend() async{
    bool? result = await showDialogWidget(context: Get.overlayContext!, message: _createContent());
    if(result != null && result){
      crearSolicitud();
    }
  }

  String _createContent(){
    String content =  '¿Esta seguro de enviar las siguientes solicitudes?';
    for (PendienteEntity selected in pendientes) {
      content += (selected.isAccepted ?? false) ? '\nAprobada: ' : '\nRechazada: ';
      content+=' S/ ${selected.importe} - ${selected.nomcomp}. ';
    }
    return content;
  }

  Future<void> crearSolicitud() async {
    validando = true;
    update([validandoId]);
    List<ManageRequestResponse> requests = pendientes.map(
      (e) => ManageRequestResponse(
        id: e.id.toString(), 
        codigoestado: (e.isAccepted ?? false) ? 'A' : 'R',
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
      Get.find<HomeAprobarController>().clearElement(toDelete: results);
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