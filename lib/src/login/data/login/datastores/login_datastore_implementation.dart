
import 'package:app_metor/src/login/data/login/contants.dart';
import 'package:app_metor/src/login/data/login/responses/sap_response.dart';
import 'package:app_metor/src/login/domain/login/datastores/login_datastore.dart';
import 'package:app_metor/src/login/domain/login/entities/login_entity.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/app_http_manager.dart';
import 'package:app_metor/src/utils/data/app_response_http.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class LoginDatastoreImplementation extends LoginDatastore{

  @override
  Future<ResultType<UserEntity, ErrorEntity>> getLogin({required LoginEntity loginEntity}) async {
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: loginGetUrl(
        username: loginEntity.cedula, 
        password: loginEntity.password,
      ),
    );
    if(res.isSuccessful){
      final sapResponse = sapResponseFromJson(
        res.body,
        (x)=> UserEntity.fromJson(x) 
        );
      final results = sapResponse.d.results;
      if(results.isEmpty){
        return Error(error: ErrorEntity(code: '404', message: 'No se encontró ningun usuario con estos datos.'));
      }else{
        return Success(data: sapResponse.d.results.first);
      }
    }else{
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un problema, contacte con informática.'));
    }
    
  }

}