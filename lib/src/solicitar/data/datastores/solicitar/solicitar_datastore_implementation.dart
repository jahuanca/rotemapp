
import 'dart:io';

import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/login/data/login/responses/sap_response.dart';
import 'package:app_metor/src/solicitar/data/contants.dart';
import 'package:app_metor/src/solicitar/data/request/get_user_amount_request.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/solicitar/domain/datastores/solicitar_datastore.dart';
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/data/app_http_manager.dart';
import 'package:app_metor/src/utils/data/app_response_http.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class SolicitarDatastoreImplementation extends SolicitarDatastore{
  
  @override
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getSolicitudes({
    required String cedula,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    }) async{
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: getSolicitudesUrl(
        cedula: cedula,
        fechaInicio: fechaInicio.toIso8601String(),
        fechaFin: fechaFin.toIso8601String()
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
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un error'));
    }
  }

  @override
  Future<ResultType<List<AmountEntity>, ErrorEntity>> getUserAmounts({required String cedula}) async{
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: getUserAmountsUrl(
        cedula: cedula, 
      ),
    );

    if(res.isSuccessful){
      final sapResponse = sapResponseFromJson(
        res.body,
        (x)=> AmountEntity.fromJson(x)
        );
      List<AmountEntity> results 
        = sapResponse.d.results.whereType<AmountEntity>().toList();
      return Success(data: results);
    }else{
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un error'));
    }
  }
  
  @override
  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> getTokenCreateRequest() async {
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: getTokenCreateRequestUrl,
      replaceAllUrl: true,
      headers: {xCsrfTokenHeader: fetchValue,}
    );

    if(res.isSuccessful){
      String token = res.headers[xCsrfTokenHeader].toString();
      String cookie = res.headers[HttpHeaders.setCookieHeader]?.split(',').last ?? emptyString;
      return Success(data: XCsrfTokenResponse(cookie: cookie, token: token));
    }else{
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un error: ${res.body}'));
    }
  }

  @override
  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> createUserRequest({required List<GetUserAmountRequest> requests}) async{
    ResultType<XCsrfTokenResponse, ErrorEntity> tokenRequest = await getTokenCreateRequest();
    if(tokenRequest is Success){
      XCsrfTokenResponse token = tokenRequest.data as XCsrfTokenResponse;
      final http = AppHttpManager();
    List<Map<String, dynamic>> data = [];
    for (GetUserAmountRequest r in requests) {
      data.add(r.toJsonByServer());
    }

    AppResponseHttp res = await http.post(
      url: createUserRequestUrl,
      replaceAllUrl: true,
      body: data,
      headers: {
        xCsrfTokenHeader: token.token,
        HttpHeaders.cookieHeader: token.cookie
      }
    );

    if(res.isSuccessful){ 
      return Success(data: createUserRequestResponseFromJson(res.body));
    }else{
      return Error(error: ErrorEntity(code: '500', message: 'Ocurrio un error: ${res.body}'));
    }
    }else{
      return Error(error: tokenRequest.error);
    } 
  }
}