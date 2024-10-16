import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/ui/pages/detail_solicitud/detail_solicitud_controller.dart';
import 'package:app_metor/src/utils/core/formats.dart';
import 'package:app_metor/src/utils/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class DetailSolicitudPage extends StatelessWidget {
  const DetailSolicitudPage({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DetailSolicitudController>(
      init: DetailSolicitudController(),
      id: contentId,
      builder: (_) => Scaffold(
        appBar: appBarWidget(
            hasArrowBack: true,
            text: 'Detalle de solicitud'),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.view_timeline_outlined),
              title: const Text('Concepto'),
              subtitle: Text(_.solicitud?.concepto ?? emptyString),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Fecha de pago'),
              subtitle: Text(_.solicitud?.fechasolicitud.formatUI() ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.price_change_outlined),
              title: const Text('Monto'),
              subtitle: Text('S/ ${_.solicitud?.importe ?? '0'}'),
            ),
            ListTile(
              leading: const Icon(Icons.star_border),
              title: const Text('Estado'),
              subtitle: Text(_.solicitud?.detalleestado ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
