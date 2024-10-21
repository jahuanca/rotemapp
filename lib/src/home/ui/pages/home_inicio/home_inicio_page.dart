import 'package:app_metor/src/home/ui/pages/home_inicio/home_inicio_controller.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class HomeInicioPage extends StatelessWidget {
  const HomeInicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeInicioController>(
      id: pageId,
      init: HomeInicioController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Inicio'),
        backgroundColor: const Color.fromARGB(255, 255, 242, 242),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: primaryColor(),
                    ),
                    borderRadius: BorderRadius.circular(borderRadius())),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _data(title: 'Cédula:', value: _.userEntity.iusuario ),
                      _data(
                          title: 'Nombre:', value: _.userEntity.nomcomp),
                      _data(title: 'Área:', value: 'Contabilidad'),
                      _data(title: 'Perfil:', value: _.userEntity.detalleperfil),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                    'assets/images/icon_app.png',
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _data({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),)),
        Expanded(child: Text(value)),
      ],
    );
  }
}
