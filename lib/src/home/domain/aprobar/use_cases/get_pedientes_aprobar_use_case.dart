
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class GetPedientesAprobarUseCase{

  AprobarRepository repository;

  GetPedientesAprobarUseCase({
    required this.repository,
  });

  Future<ResultType<List<PendienteEntity>, ErrorEntity>> execute({required String cedula}) async{
    return await repository.getPendientesAprobar(cedula: cedula);
  }

}