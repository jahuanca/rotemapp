
import 'package:app_metor/src/home/data/constants.dart';
import 'package:app_metor/src/home/domain/aprobar/datastores/aprobar_datastore.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/login/data/login/responses/sap_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/app_http_manager.dart';
import 'package:app_metor/src/utils/data/app_response_http.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class AprobarDatastoreImplementation extends AprobarDatastore{
  @override
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getPendientesAprobar({required String cedula}) async{
    
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: getPendientesAprobarUrl(
        cedula: cedula,
      ),
    );
    if(res.isSuccessful){
      final sapResponse = sapResponseFromJson(
        res.body,
        (x)=> PendienteEntity.fromJson(x)
        );
      List<PendienteEntity> results 
        = sapResponse.d.results.whereType<PendienteEntity>().toList();
      return Success(data: results);
    }else{
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un problema, contacte con informática.'));
    }
  }
}