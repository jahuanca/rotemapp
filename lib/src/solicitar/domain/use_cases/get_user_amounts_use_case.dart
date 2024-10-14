
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/solicitar/domain/repositories/solicitar_repository.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';

class GetUserAmountsUseCase{

  SolicitarRepository repository;

  GetUserAmountsUseCase({
    required this.repository
  });

  Future<ResultType<List<AmountEntity>, ErrorEntity>> execute({required String cedula}) async{
    return repository.getUserAmounts(cedula: cedula);
  }

}