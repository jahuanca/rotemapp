import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';

List<CreateUserRequestResponse> createFakeResult(List<int> ids){
  return ids.map((e) => CreateUserRequestResponse(
    id: e, 
    pernr: 12, 
    fechaTransf: DateTime.now(), 
    horaTransf: "052331", 
    estado: "C", 
    mensaje: "Solicitud se registró satisfactoriamente.", 
    success: "0"
  )).toList();
}

final resultsOfSuccess =[
  CreateUserRequestResponse(
    id: 1, 
    pernr: 12, 
    fechaTransf: DateTime.now(), 
    horaTransf: "052331", 
    estado: "C", 
    mensaje: "Solicitud se registró satisfactoriamente.", 
    success: "0"
  ),
  CreateUserRequestResponse(
    id: 3, 
    pernr: 14, 
    fechaTransf: DateTime.now(), 
    horaTransf: "052331", 
    estado: "C", 
    mensaje: "Solicitud se registró satisfactoriamente.", 
    success: "1"
  ),
];