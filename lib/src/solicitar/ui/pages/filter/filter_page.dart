import 'package:app_metor/src/solicitar/core/strings.dart';
import 'package:app_metor/src/solicitar/ui/pages/filter/filter_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<FilterController>(
      init: FilterController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(hasArrowBack: true, text: 'Filtros'),
        body: Column(
          children: [
            const ListTile(
              title: Text('Fecha'),
              subtitle: Text('12/08/2024 - 20/08/2024'),
              leading: Icon(Icons.date_range_outlined),
              trailing: Icon(Icons.arrow_drop_down),
            ),
            GetBuilder<FilterController>(
              id: montoMinId,
              builder: (_) => ListTile(
                title: Text('Montos mayores a: ${_.minMontoToFilter.toInt()}'),
                subtitle: Slider(
                    min: 0,
                    max: 100,
                    value: _.minMontoToFilter,
                    onChanged: _.onChangedMonto),
                leading: const Icon(Icons.price_change_outlined),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.star_outline),
              title: Text('Estados'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<FilterController>(
                id: allStatesId,
                builder: (_) => Column(
                  children: [
                    CheckboxListTile(
                        title: const Text('Todos'), 
                        value: const DeepCollectionEquality
                          .unordered().equals(_.status, [codeCompleta, codePendiente, codeRechazada]), 
                        onChanged: _.onChangedAllStates),
                    CheckboxListTile(
                        title: const Text('Pendientes'), 
                        value: _.status.contains(codePendiente), 
                        onChanged: (val)=> _.onChangeState(val, codePendiente)),
                    CheckboxListTile(
                        title: const Text('Rechazadas'), 
                        value: _.status.contains(codeRechazada), 
                        onChanged: (val)=> _.onChangeState(val, codeRechazada)),
                    CheckboxListTile(
                        title: const Text('Completados'),
                        value: _.status.contains(codeCompleta), 
                        onChanged: (val)=> _.onChangeState(val, codeCompleta)),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ButtonWidget(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1, bottom: 20),
            text: 'Filtrar'),
      ),
    );
  }
}
