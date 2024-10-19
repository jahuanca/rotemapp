
import 'package:app_metor/src/home/data/responses/manage_request_response.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

abstract class AprobarRepository{
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getPendientesAprobar({required String cedula});
  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> getTokenCreateRequest();
  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> manageRequest({
    required List<ManageRequestResponse> requests,
    required XCsrfTokenResponse token,
  });
}