
import 'package:app_metor/src/login/domain/login/entities/login_entity.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

abstract class LoginDatastore{
  Future<ResultType<UserEntity, ErrorEntity>> getLogin({required LoginEntity loginEntity});
}