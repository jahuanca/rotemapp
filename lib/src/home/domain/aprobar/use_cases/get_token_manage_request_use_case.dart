
import 'package:app_metor/src/home/domain/aprobar/repositories/aprobar_repository.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class GetTokenManageRequestUseCase{

  AprobarRepository repository;

  GetTokenManageRequestUseCase({
    required this.repository,
  });

  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> execute(){
    return repository.getTokenCreateRequest();
  }


}