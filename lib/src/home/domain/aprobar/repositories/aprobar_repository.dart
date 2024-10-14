
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

abstract class AprobarRepository{
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getPendientesAprobar({required String cedula});
}