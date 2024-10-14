
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class GetTokenCreateRequestUseCase{

  SolicitarRepository repository;

  GetTokenCreateRequestUseCase({
    required this.repository,
  });

  Future<ResultType<XCsrfTokenResponse, ErrorEntity>> execute() async {
    return repository.getTokenCreateRequest();
  }

}