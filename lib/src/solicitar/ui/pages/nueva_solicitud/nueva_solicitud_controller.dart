import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/data/request/get_user_amount_request.dart';
import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/solicitar/data/responses/x_csrf_token_response.dart';
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/create_user_request_use_case.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/get_token_create_request_use_case.dart';
import 'package:app_metor/src/solicitar/domain/use_cases/get_user_amounts_use_case.dart';
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:app_metor/src/utils/core/result_type.dart';
import 'package:app_metor/src/utils/data/error_entity.dart';
import 'package:app_metor/src/utils/ui/pages/results/results_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class NuevaSolicitudController extends GetxController {
  GetUserAmountsUseCase getUserAmountsUseCase;
  GetTokenCreateRequestUseCase getTokenCreateRequestUseCase;
  CreateUserRequestUseCase createUserRequestUseCase;

  List<AmountEntity> amountsOfResponseUser = [];
  bool validando = false;
  Map<int, GetUserAmountRequest> requestsToSendServer = {};
  String? cedula;

  NuevaSolicitudController({
    required this.getUserAmountsUseCase,
    required this.getTokenCreateRequestUseCase,
    required this.createUserRequestUseCase,
  });

  @override
  void onReady() {
    getUserAmounts();
    super.onReady();
  }

  Future<void> getUserAmounts() async {
    UserPreferences userPreferences = UserPreferences();
    cedula = userPreferences.getString(cedulaKey);
    if (cedula != null) {
      validando = true;
      update([validandoId]);
      ResultType<List<AmountEntity>, ErrorEntity> resultType =
          await getUserAmountsUseCase.execute(cedula: cedula.toString());
      if (resultType is Success) {
        amountsOfResponseUser = resultType.data as List<AmountEntity>;
      }
      validando = false;
      update([validandoId, listadoId]);
    }
  }

  void onChangeChecked(bool? value, int index) {
    if (cedula == null) return;
    if (value ?? false) {
      requestsToSendServer[index] = GetUserAmountRequest(
          cedula: cedula.toString(),
          fechasolicitud: DateTime.now(),
          importe: null,
          concepto: amountsOfResponseUser[index].detallecodigocc,
          codigoAmount: amountsOfResponseUser[index].codigocc);
    } else {
      requestsToSendServer.remove(index);
    }
    FocusScope.of(Get.overlayContext!).unfocus();
    amountsOfResponseUser[index].showItem = value;
    update(['$amountId$index', requestId]);
  }

  void onChangeAmount(String value, int index) {
    requestsToSendServer[index]?.importe = value;
    requestsToSendServer[index]?.errorAmount =
        validatorText(text: value, label: '', rules: {
      RuleValidator.isRequired: true,
      RuleValidator.isDouble: true,
      RuleValidator.minValue: 0,
      RuleValidator.maxValue:
          double.parse(amountsOfResponseUser[index].importe),
    })?.trim().capitalizeFirst;

    if (requestsToSendServer[index]?.errorAmount == null) {
      requestsToSendServer[index]?.importe = value;
    } else {
      requestsToSendServer[index]?.importe = null;
    }

    update(['$amountId$index']);
  }

  Future<void> crearSolicitud() async {
    for (GetUserAmountRequest r in requestsToSendServer.values) {
      if (r.errorAmount != null || r.importe == null) {
        showSnackbarWidget(
            context: Get.overlayContext!,
            typeSnackbar: TypeSnackbar.error,
            message: 'El monto del concepto ${r.concepto} esta errado.');
        return;
      }
    }
    validando = true;
    update([validandoId]);
    ResultType<XCsrfTokenResponse, ErrorEntity> resultType =
        await getTokenCreateRequestUseCase.execute();
    if (resultType is Success) {
      _createUserRequest(tokenResponse: resultType.data as XCsrfTokenResponse);
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: (resultType.error as ErrorEntity).message);
      validando = false;
      update([validandoId]);
    }
  }

  Future<void> _createUserRequest(
      {required XCsrfTokenResponse tokenResponse}) async {
    List<GetUserAmountRequest> requests = requestsToSendServer.values.toList();
    ResultType<List<CreateUserRequestResponse>, ErrorEntity> resultType =
        await createUserRequestUseCase.execute(
      requests: requests,
      token: tokenResponse,
    );
    if (resultType is Success) {
      List<CreateUserRequestResponse> results =
          resultType.data as List<CreateUserRequestResponse>;
      for (int i = 0; i < results.length; i++) {
        GetUserAmountRequest amountRequest = requests
            .firstWhere(
              (e) => results[i].mensaje.contains(e.codigoAmount),
            );
        results[i].amount = 
           (results[i].success == "0") ? 'S/ ${amountRequest.importe}' : 'S/ ${amountRequest.importe}';
        results[i].detail = 
           (results[i].success == "0") ? amountRequest.concepto : amountRequest.concepto;
      }
      Get.off(() => const ResultsPage(), arguments: {
        responsesKey: results
      });
    } else {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: (resultType.error as ErrorEntity).message);
    }
    validando = false;
    update([validandoId]);
  }
}
