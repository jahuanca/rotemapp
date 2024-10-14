import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/ui/pages/detail_solicitud/detail_solicitud_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class DetailSolicitudPage extends StatelessWidget {
  const DetailSolicitudPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<DetailSolicitudController>(
      init: DetailSolicitudController(),
      id: contentId,
      builder: (_) => Scaffold(
        appBar: appBarWidget(
            hasArrowBack: true,
            text: _.isNewDetail ? 'Crear solicitud' : 'Detalle de solicitud'),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Fecha de pago'),
              subtitle: Text(_.solicitud?.fechasolicitud ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.price_change_outlined),
              title: const Text('Monto'),
              subtitle: Text('S/ ${_.solicitud?.importe ?? '0'}'),
            ),
          ],
        ),
        bottomNavigationBar: ButtonWidget(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1, bottom: 20),
            text: _.sentFromApprovePage
                ? 'Aprobar'
                : _.isNewDetail
                    ? 'Crear'
                    : 'Sincronizar'),
      ),
    );
  }
}
