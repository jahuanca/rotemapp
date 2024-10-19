import 'package:app_metor/src/solicitar/data/responses/create_user_request_response.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:app_metor/src/utils/ui/pages/results/results_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ResultsController>(
      init: ResultsController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Resultados'),
        body: ListView.builder(
          itemCount: _.responses.length,
          itemBuilder: (context, index) => _itemResult(
            size: size,
            response: _.responses[index]
            ),
        ),
      ),
    );
  }

  Widget _itemResult({
    required Size size,
    required CreateUserRequestResponse response,
    }) {
    const double dimen = 16;
    final isSuccess = (response.success == "0");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSuccess ? successColor() : dangerColor(),
              ),
              borderRadius: BorderRadius.circular(borderRadius()),
              color: Colors.white,
            ),
            width: size.width,
            height: size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: dimen, horizontal: dimen),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: isSuccess ? successColor() : dangerColor(),
                        child: Icon(
                          isSuccess ? Icons.check : Icons.close,
                          color: Colors.white,
                        ),
                      )),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            isSuccess ? response.amount ?? emptyString  : 'Error',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text( isSuccess 
                            ? 'Solicitud se registro satisfactoriamente' 
                            : response.mensaje ,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300)),
                          
                          Text(response.detail ?? emptyString,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
