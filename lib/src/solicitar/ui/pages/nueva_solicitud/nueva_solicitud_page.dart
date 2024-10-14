import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/domain/entities/amount_entity.dart';
import 'package:app_metor/src/solicitar/ui/pages/nueva_solicitud/nueva_solicitud_controller.dart';
import 'package:app_metor/src/utils/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class NuevaSolicitudPage extends StatelessWidget {
  NuevaSolicitudPage({super.key});

  final NuevaSolicitudController controller =
      Get.find<NuevaSolicitudController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<NuevaSolicitudController>(
      init: controller,
      builder: (_) => Stack(
        children: [
          Scaffold(
            appBar: appBarWidget(
              hasArrowBack: true,
              text: 'Crear solicitud',
            ),
            bottomNavigationBar: GetBuilder<NuevaSolicitudController>(
              id: requestId,
              builder: (_) => _.request.isEmpty
                  ? const SizedBox()
                  : ButtonWidget(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      onTap: _.crearSolicitud,
                      text: 'Crear'),
            ),
            body: GetBuilder<NuevaSolicitudController>(
              id: listadoId,
              builder: (_) => ListView.builder(
                itemCount: _.amounts.length,
                itemBuilder: (context, index) => _itemAmount(
                  amount: _.amounts[index],
                  index: index,
                  size: size,
                ),
              ),
            ),
          ),
          GetBuilder<NuevaSolicitudController>(
            id: validandoId,
            builder: (_) => LoadingWidget(show: _.validando),
          ),
        ],
      ),
    );
  }

  Widget _itemAmount({
    required AmountEntity amount,
    required int index,
    required Size size,
  }) {
    return GetBuilder<NuevaSolicitudController>(
      id: '$amountId$index',
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GetBuilder<NuevaSolicitudController>(
            builder: (_) => Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CheckboxListTile(
                value: amount.showItem ?? false,
                onChanged: (value) => _.onChangeChecked(value, index),
                title: Text(amount.detallecodigocc),
                subtitle: Text('Monto máximo: S/ ${amount.importe}'),
              ),
            ),
          ),
          GetBuilder<NuevaSolicitudController>(
            builder: (_) => AnimatedOpacity(
              opacity: (amount.showItem ?? false) ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              child: (amount.showItem ?? false)
                  ? Container(
                      alignment: Alignment.centerLeft,
                      width: size.width * 0.7,
                      height: size.height * 0.1,
                      child: InputWidget(
                        padding: const EdgeInsets.only(right: 15),
                        icon: const Icon(Icons.money_rounded),
                        textInputType: TextInputType.number,
                        hintText: 'Monto solicitado',
                        onChanged: (val) => _.onChangeAmount(val, index),
                        error: _.request[index].errorAmount,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
