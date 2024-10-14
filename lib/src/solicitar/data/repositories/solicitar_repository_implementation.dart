
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/data/request/get_user_amount_request.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/solicitar/domain/datastores/solicitar_datastore.dart';
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class SolicitarRepositoryImplementation extends SolicitarRepository{

  SolicitarDatastore datastore;

  SolicitarRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<List<PendienteEntity>, ErrorEntity>> getSolicitudes({required String cedula}) async {
    return datastore.getSolicitudes(cedula: cedula);
  }

  @override
  Future<ResultType<List<AmountEntity>, ErrorEntity>> getUserAmounts({required String cedula}) {
    return datastore.getUserAmounts(cedula: cedula);
  }
  
  @override
  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> getTokenCreateRequest() 
    => datastore.getTokenCreateRequest();

  @override
  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> createUserRequest({required List<GetUserAmountRequest> requests, required XCsrfTokenResponse token,}) {
    return datastore.createUserRequest(requests: requests, token: token);
  }

}