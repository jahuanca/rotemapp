import 'package:app_metor/src/aprobar/ui/pages/aprobar_page/aprobar_controller.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/utils/core/formats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class AprobarPage extends StatelessWidget {
  AprobarPage({super.key});

  final AprobarController controller = Get.find<AprobarController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AprobarController>(
      init: controller,
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Aprobar o rechazar', hasArrowBack: true),
        bottomNavigationBar: GetBuilder<AprobarController>(
              id: seleccionadosId,
              builder: (_) => _.pendientes.any((e) => e.isAccepted != null,)
                  ? ButtonWidget(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      onTap: ()=> _.goSend(),
                      text: 'Enviar')
                  : const SizedBox(),
            ),
        body: GetBuilder<AprobarController>(
          id: listadoId,
          builder: (_) => ListView.builder(
            itemCount: _.pendientes.length + 1,
            itemBuilder: (context, index) => (index == 0)
                ? _header()
                : _item(
                    pendiente: _.pendientes[index - 1],
                    index: index - 1,
                    controller: _,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _item({
    required PendienteEntity pendiente,
    required int index,
    required AprobarController controller,
  }) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text('S/\n${pendiente.importe.formatImporte()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ))),
        Expanded(
          flex: 4,
          child: ListTile(
            title: Text(pendiente.concepto ?? 'Sin concepto'),
            subtitle: Text(pendiente.fechasolicitud.formatUI()),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Radio(
                    value: true,
                    activeColor: const Color(0xFF6200EE),
                    groupValue: pendiente.isAccepted,
                    onChanged: (val) =>
                        controller.onChangePendiente(val, index)),
              ),
              Expanded(
                child: Radio(
                    value: false,
                    groupValue: pendiente.isAccepted,
                    onChanged: (val) =>
                        controller.onChangePendiente(val, index)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(
              flex: 2,
              child: Text('Monto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))),
          const Expanded(
            flex: 4,
            child: Text('Concepto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Icon(Icons.check, color: successColor(),)),
                Expanded(child: Icon(Icons.close, color: dangerColor(),)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
