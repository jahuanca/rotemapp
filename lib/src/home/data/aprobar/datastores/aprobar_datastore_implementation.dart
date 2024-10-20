import 'dart:io';

import 'package:app_metor/src/home/data/constants.dart';
import 'package:app_metor/src/home/data/responses/manage_request_response.dart';
import 'package:app_metor/src/home/domain/aprobar/datastores/aprobar_datastore.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/login/data/login/responses/sap_response.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/data/app_http_manager.dart';
import 'package:app_metor/src/utils/data/app_response_http.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class AprobarDatastoreImplementation extends AprobarDatastore {
  @override
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getPendientesAprobar(
      {required String cedula}) async {
    final http = AppHttpManager();

    AppResponseHttp res = await http.get(
      url: getPendientesAprobarUrl(
        cedula: cedula,
      ),
    );
    if (res.isSuccessful) {
      final sapResponse =
          sapResponseFromJson(res.body, (x) => PendienteEntity.fromJson(x));
      List<PendienteEntity> results =
          sapResponse.d.results.whereType<PendienteEntity>().toList();
      return Success(data: results);
    } else {
      return Error(
          error: ErrorEntity(
              code: '500',
              message: 'Ocurrio un problema, contacte con informática.'));
    }
  }

  @override
  Future<ResultType<XCsrfTokenResponse, ErrorEntity>>
      getTokenCreateRequest() async {
    final http = AppHttpManager();

    AppResponseHttp res = await http
        .get(url: getTokenManageRequestUrl, replaceAllUrl: true, headers: {
      xCsrfTokenHeader: fetchValue,
    });

    if (res.isSuccessful) {
      String token = res.headers[xCsrfTokenHeader].toString();
      String cookie =
          res.headers[HttpHeaders.setCookieHeader]?.split(',').last ??
              emptyString;
      return Success(data: XCsrfTokenResponse(cookie: cookie, token: token));
    } else {
      return Error(
          error: ErrorEntity(
              code: '500', message: 'Ocurrio un error: ${res.body}'));
    }
  }

  @override
  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>>
      manageRequest({required List<ManageRequestResponse> requests,}) async {
    ResultType<XCsrfTokenResponse, ErrorEntity> tokenRequest =
        await getTokenCreateRequest();
    if (tokenRequest is Success) {
      XCsrfTokenResponse token = tokenRequest.data as XCsrfTokenResponse;
      final http = AppHttpManager();
      List<Map<String, dynamic>> data = [];
      for (ManageRequestResponse r in requests) {
        data.add(r.toJson());
      }

      AppResponseHttp res = await http.post(
          url: manageRequestUrl,
          replaceAllUrl: true,
          body: data,
          headers: {
            xCsrfTokenHeader: token.token,
            HttpHeaders.cookieHeader: token.cookie
          });

      if (res.isSuccessful) {
        return Success(data: createUserRequestResponseFromJson(res.body));
      } else {
        return Error(
            error: ErrorEntity(
                code: '500', message: 'Ocurrio un error: ${res.body}'));
      }
    } else {
      return Error(error: tokenRequest.error);
    }
  }
}
