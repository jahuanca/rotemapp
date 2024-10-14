
import 'package:app_metor/src/home/domain/aprobar/datastores/aprobar_datastore.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class AprobarRepositoryImplementation extends AprobarRepository{

  AprobarDatastore datastore;

  AprobarRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getPendientesAprobar({required String cedula}) async{
    return await datastore.getPendientesAprobar(cedula: cedula);
  }


}