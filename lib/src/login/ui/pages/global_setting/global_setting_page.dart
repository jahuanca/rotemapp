import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/login/ui/pages/global_setting/global_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class GlobalSettingPage extends StatelessWidget {
  const GlobalSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalSettingController>(
      init: GlobalSettingController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Configuración global'),
        body: Column(
          children: [
            GetBuilder<GlobalSettingController>(
              id: ambienteId,
              builder: (_) => _ambiente(controller: _))
          ],
        ),
      ),
    );
  }

  Widget _ambiente({
    required GlobalSettingController controller,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          child: Text('Ambiente', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),),
        ),
            RadioListTile(
              title: const Text('Pruebas'),
              value: false,
              groupValue: controller.isQas,
              onChanged: controller.changeAmbiente,
            ),
            RadioListTile(
              title: const Text('Producción'),
              value: true,
              groupValue: controller.isQas,
              onChanged: controller.changeAmbiente,
            )
      ],
    );
  }
}
