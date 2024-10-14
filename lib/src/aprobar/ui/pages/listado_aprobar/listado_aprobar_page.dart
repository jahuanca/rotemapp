import 'package:app_metor/src/aprobar/ui/pages/listado_aprobar/listado_aprobar_controller.dart';
import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/utils/core/formats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class ListadoAprobarPage extends StatelessWidget {
  ListadoAprobarPage({super.key});

  final ListadoAprobarController controller =
      Get.find<ListadoAprobarController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<ListadoAprobarController>(
      init: controller,
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Aprobaciones pendientes'),
        backgroundColor: backgroundPageColor(),
        body: SizedBox(
          height: size.height,
          child: Column(
            children: [
              _searchAndFilter(),
              Expanded(
                child: GetBuilder<ListadoAprobarController>(
                  id: listadoId,
                  builder: (_) => _.pendientesMostradas.isEmpty
                      ? const Center(
                          child: Text('No se encontraron resultados'))
                      : ListView.builder(
                          itemCount: _.pendientesMostradas.length,
                          itemBuilder: (context, index) =>
                              _item(size: size, index: index),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({required Size size, required int index}) {
    List<PendienteEntity> pendientesByUser =
        controller.pendientesMostradas.values.elementAt(index);

    int quantityElements = pendientesByUser.length;
    String nameUser = pendientesByUser.first.nomcomp.toString();
    double amountAll = pendientesByUser.fold(
      0,
      (acc, e) => acc + e.importe,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () => controller.goDetailSolicitud(pendientesByUser),
        child: Container(
          width: size.width,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius()),
              border: Border.all(color: Colors.grey)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 10,
                  child: Center(
                      child: Text(
                    'S/\n${amountAll.formatImporte()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
              Expanded(
                  flex: 32,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          nameUser.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(pendientesByUser.first.fechasolicitud),
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey)),
                    child: CircleAvatar(
                        backgroundColor:
                            pendientesByUser.first.colorState.withAlpha(20),
                        child: Center(child: Text(quantityElements.toString()))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchAndFilter() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: GetBuilder<ListadoAprobarController>(
                id: valorBuscadoId,
                builder: (_) => InputWidget(
                  onChanged: _.onChangedValorBuscar,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'Buscar solicitud',
                  iconOverlay: _.valorBuscar.isEmpty ? null : Icons.close,
                  onPressedIconOverlay:
                      _.valorBuscar.isEmpty ? null : _.clearValorBuscado,
                  textEditingController: _.valorBuscadoTextEditingController,
                  focusNode: _.focusValorBuscado,
                  icon: const Icon(Icons.search_outlined),
                ),
              )),
        ],
      ),
    );
  }
}
