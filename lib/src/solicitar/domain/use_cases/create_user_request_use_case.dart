
import 'package:app_metor/src/solicitar/data/request/get_user_amount_request.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class CreateUserRequestUseCase{

  SolicitarRepository repository;

  CreateUserRequestUseCase({
    required this.repository,
  });

  Future<ResultType<List<CreateUserRequestResponse>, ErrorEntity>> execute({required List<GetUserAmountRequest> requests,}) async {
    return repository.createUserRequest(requests: requests,);
  }

}