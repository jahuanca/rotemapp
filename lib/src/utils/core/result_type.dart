
import 'dart:developer';

import 'package:app_metor/src/utils/data/error_entity.dart';

class ResultType<T, U>{
  get data => T;
  get error => U;
}

class Success<T,U> extends ResultType<T, U>{
  @override
  final T data;
  Success({required this.data});
}

class Error<T,U> extends ResultType<T,U>{
  @override
  final dynamic error;
  Error({this.error});
}

dynamic switchResultType(ResultType<dynamic, ErrorEntity> result) {
  if (result is Success) {
    return result.data;
  }
  if (result is Error) {
    log(result.error.toString());
    return result.error;
  }
}