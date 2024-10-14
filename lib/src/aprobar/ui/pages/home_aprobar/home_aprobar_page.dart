import 'package:app_metor/src/home/domain/aprobar/entities/pendiente_entity.dart';
import 'package:app_metor/src/aprobar/ui/pages/home_aprobar/home_aprobar_controller.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/utils/core/formats.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class HomeAprobarPage extends StatelessWidget {

  HomeAprobarPage({super.key});

  final HomeAprobarController controller = Get.find<HomeAprobarController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAprobarController>(
      init: controller,
      id: pageId,
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Aprobar'),
        backgroundColor: backgroundPageColor(),
        body: 
           RefreshIndicator(
            onRefresh: _.getPendientesAprobar,
             child: Stack(
               children: [
                 ListView.builder(
                  itemCount: _.agrupadas.length,
                  itemBuilder: (context, index) => area(
                      title: _.agrupadas.keys.elementAt(index), 
                      amount: 'S/ ${ _.agrupadas.values.elementAt(index).first.importeTotal?.formatImporte()}',
                      quantity: _.agrupadas.values.elementAt(index).length.toString(),
                      index: index,
                      ),
                  ),
                GetBuilder<HomeAprobarController>(
                  id: validandoId,
                  builder: (_) => _.validando ? Container(
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ): Container()),
               ],
             ),
           ),
      ),
    );
  }

  Widget area({
    required String title,
    required String amount,
    required String quantity,    
    required int index,
  }) {

    List<PendienteEntity> people = controller.agrupadas.values.elementAt(index);
    Map<String, List<PendienteEntity>> groupByUsers = groupBy(people, (e) => e.codigo,);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(borderRadius()),
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          title: ListTile(
            title: Text(title),
          ),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Icon(Icons.price_change_outlined), Text(amount)],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Icon(Icons.list), Text(quantity)],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Icon(Icons.people_outline), Text(groupByUsers.length.toString())],
            ),
            Container(
              width: 140,
              height: 60,
              padding: const EdgeInsets.all(10.0),
              child: ButtonWidget(
                onTap: () => controller.goListadoAprobar(index, groupByUsers) ,
                text: 'Ver',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
