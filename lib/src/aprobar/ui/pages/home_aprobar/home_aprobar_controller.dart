import 'package:app_metor/src/aprobar/di/listado_aprobar_binding.dart';
import 'package:app_metor/src/aprobar/ui/pages/listado_aprobar/listado_aprobar_page.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/home/domain/aprobar/use_cases/get_pedientes_aprobar_use_case.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class HomeAprobarController extends GetxController {
  GetPedientesAprobarUseCase getPedientesAprobarUseCase;
  final List<PendienteEntity> _pendientesEntity = [];
  Map<String, List<PendienteEntity>> agrupadas = {};
  bool validando = false;

  HomeAprobarController({
    required this.getPedientesAprobarUseCase,
  });

  @override
  void onReady() {
    getPendientesAprobar();
    super.onReady();
  }

  Future<void> getPendientesAprobar() async {
    UserPreferences userPreferences = UserPreferences();
    String? cedula = userPreferences.getString(cedulaKey);

    if (cedula != null) {
      _pendientesEntity.clear();
      validando = true;
      update([validandoId]);
      ResultType<List<PendienteEntity>, ErrorEntity> result =
          await getPedientesAprobarUseCase.execute(cedula: cedula);
      if (result is Success) {
        _pendientesEntity.addAll(result.data as List<PendienteEntity>);
        _agrupar();
      } else {

      }
      validando = false;
      update([validandoId]);
    }
  }

  void _calcularImporte(){
    for (List<PendienteEntity> element in agrupadas.values) {
          double importeTotal = 0;
          for (PendienteEntity e in element) {
            double importe = e.importe.toDouble();
            importeTotal += importe;
          }
          element.first.importeTotal = importeTotal;
        }
  }

  Future<void> goListadoAprobar(int index, Map<String, List<PendienteEntity>> groupByUsers) async{
    Get.to<bool?>(() => ListadoAprobarPage(), arguments: {
      groupByUsersArgument: groupByUsers,
      conceptArgument: agrupadas.keys.elementAt(index),
    }, binding: ListadoAprobarBinding()
    );
  }

  void clearElement({
    required List<CreateUserRequestResponse> toDelete}){
    for (var elementToDelete in toDelete) {
      _pendientesEntity.removeWhere((e) => e.id == elementToDelete.id,);
      _agrupar();
    }
  }

  void _agrupar(){
    agrupadas = groupBy(_pendientesEntity.toList(), (e) => e.concepto ?? e.codigo );
    _calcularImporte();
    update([pageId]);
  }
}
