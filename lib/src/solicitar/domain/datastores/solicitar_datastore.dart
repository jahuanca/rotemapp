
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/data/request/get_user_amount_request.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

abstract class SolicitarDatastore{
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getSolicitudes({
    required String cedula,
    required DateTime fechaInicio,
    required DateTime fechaFin,
    });
  Future<ResultType<List<AmountEntity>, ErrorEntity>> getUserAmounts({required String cedula});
  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> getTokenCreateRequest();
  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> createUserRequest({
    required List<GetUserAmountRequest> requests,
  });


}