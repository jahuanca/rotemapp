
import 'package:app_metor/src/home/data/responses/manage_request_response.dart';
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class ManageRequestUseCase{

  AprobarRepository repository;

  ManageRequestUseCase({
    required this.repository,
  });

  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> execute({
    required List<ManageRequestResponse> requests,
    required XCsrfTokenResponse token
  }){
    return repository.manageRequest(requests: requests, token: token);
  }

}