import 'package:app_metor/src/aprobar/ui/pages/aprobar_page/aprobar_controller.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/utils/core/formats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class AprobarPage extends StatelessWidget {
  const AprobarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AprobarController>(
      init: AprobarController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Aprobar o rechazar', hasArrowBack: true),
        body: GetBuilder<AprobarController>(
          id: listadoId,
          builder: (_) => ListView.builder(
            itemCount: _.pendientes.length,
            itemBuilder: (context, index) => _item(
              pendiente: _.pendientes[index],
              index: index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _item({
    required PendienteEntity pendiente,
    required int index,
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
            title: Expanded(child: Text(pendiente.codigo)),
            subtitle: Text(pendiente.fechasolicitud),
          ),
        ),
        const Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Radio(value: 0, groupValue: '133', onChanged: print),
              ),
              Expanded(
                child: Radio(value: 0, groupValue: '133', onChanged: print),
              ),
            ],
          ),
        )
      ],
    );
  }
}
