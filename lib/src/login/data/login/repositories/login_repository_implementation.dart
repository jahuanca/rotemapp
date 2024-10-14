
import 'package:app_metor/src/login/domain/login/datastores/login_datastore.dart';
import 'package:app_metor/src/login/domain/login/entities/login_entity.dart';
import 'package:app_metor/src/login/domain/login/entities/user_entity.dart';
import 'package:app_metor/src/login/domain/login/repositories/login_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class LoginRepositoryImplementation extends LoginRepository{

  final LoginDatastore datastore;

  LoginRepositoryImplementation({
    required this.datastore,
  });

  @override
  Future<ResultType<UserEntity, ErrorEntity>> getLogin({required LoginEntity loginEntity}) async{
    return await datastore.getLogin(loginEntity: loginEntity);
  }

}