
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:get/get.dart';

class ResultsController extends GetxController{


  List<CreateUserRequestResponse> responses = [];

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[responsesKey] != null){
        responses = Get.arguments[responsesKey] as List<CreateUserRequestResponse>;
      }
    }
    super.onInit();
  }

}