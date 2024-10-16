
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class GetSolicitudesUseCase{

  SolicitarRepository repository;

  GetSolicitudesUseCase({
    required this.repository,
  });

  Future<ResultType<List<PendienteEntity>, ErrorEntity>> execute({
    required String cedula,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    }) async{
    return await repository.getSolicitudes(cedula: cedula, fechaInicio: fechaInicio, fechaFin: fechaFin);
  }

}