
import 'package:app_metor/src/login/domain/login/entities/login_entity.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/login/domain/login/repositories/login_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class LoginUseCase{
  final LoginRepository repository;

  LoginUseCase({
    required this.repository,
  });

  Future<ResultType<UserEntity, ErrorEntity>> execute({
    required LoginEntity loginEntity,
  }) async{
    return await repository.getLogin(loginEntity: loginEntity);
  }
  
}