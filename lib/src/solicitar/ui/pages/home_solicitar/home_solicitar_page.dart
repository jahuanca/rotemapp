import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/ui/pages/home_solicitar/home_solicitar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class HomeSocilitarPage extends StatelessWidget {
  HomeSocilitarPage({super.key});

  final HomeSolicitarController controller =
      Get.find<HomeSolicitarController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeSolicitarController>(
      init: controller,
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Solicitudes'),
        floatingActionButton: _.sentFromApprovePage
            ? Container()
            : FloatingActionButton(
                onPressed: _.goAddSolicitud,
                child: const Icon(Icons.add),
              ),
        backgroundColor: backgroundPageColor(),
        body: SizedBox(
          height: size.height,
          child: Column(
            children: [
              Column(
                children: [
                  _searchAndFilter(controller: _),
                  if (!_.sentFromApprovePage)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagWidget(
                            padding: const EdgeInsets.only(left: 10, top: 4),
                            title: '20/10/24 - 25/10/24',
                            icon: Icons.calendar_month_outlined,
                            textColorAndIcon: Colors.white,
                          ),
                          
                          TagWidget(
                            padding: const EdgeInsets.only(left: 10, top: 4),
                            title: '> 500',
                            icon: Icons.price_change_outlined,
                            textColorAndIcon: Colors.white,
                          ),
                          TagWidget(
                            padding: const EdgeInsets.only(left: 10, top: 4),
                            title: 'R - P - E',
                            icon: Icons.star_outline_sharp,
                            textColorAndIcon: Colors.white,
                          ),
                        ],
                      ),
                    
                ],
              ),
              Expanded(
                child: GetBuilder<HomeSolicitarController>(
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () => controller.goDetailSolicitud(index),
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
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.pendientesMostradas[index].colorState
                            .withAlpha(20),
                        border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                        controller.pendientesMostradas[index].imagenEstado),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          controller.sentFromApprovePage
                              ? controller.pendientesMostradas[index].nomcomp
                                  .toString()
                              : controller
                                  .pendientesMostradas[index].fechasolicitud
                                  .toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.sentFromApprovePage ?
                          controller
                            .pendientesMostradas[index].fechasolicitud
                            .toString()
                          : "S/ ${controller
                            .pendientesMostradas[index].importe}"
                            ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(
                    controller.sentFromApprovePage
                        ? 'S/ ${controller.pendientesMostradas[index].importe}'
                        : '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchAndFilter({
    required HomeSolicitarController controller,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: GetBuilder<HomeSolicitarController>(
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
          if (!controller.sentFromApprovePage)
            IconButtonWidget(
                onPressed: controller.goFilters,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                borderRadius: BorderRadius.circular(borderRadius()),
                shape: BoxShape.rectangle,
                iconData: Icons.filter_alt),
        ],
      ),
    );
  }
}
