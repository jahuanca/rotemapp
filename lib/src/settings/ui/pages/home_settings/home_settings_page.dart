import 'package:app_metor/src/settings/ui/pages/home_settings/home_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class HomeSettingsPage extends StatelessWidget {
  const HomeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSettingsController>(
      init: HomeSettingsController(),
      builder: (_) => Scaffold(
        appBar: appBarWidget(text: 'Configuración'),
        backgroundColor: backgroundPageColor(),
        body: Column(
          children: [
            _listTile(
              title: 'Actualizar perfil',
              icon: const CircleAvatar(
                child: Icon(Icons.edit),
              ),
            ),
            _listTile(
              title: 'Cambiar contraseña',
              icon: const CircleAvatar(
                child: Icon(Icons.lock),
              ),
            ),
            _listTile(
              onTap: _.goCerrarSesion,
              title: 'Cerrar sesión',
              icon: const CircleAvatar(
                child: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const ListTile(
          title: Text('AppMetor'),
          subtitle: Text('Versión 1.0.0'),
        ),
      ),
    );
  }

  Widget _listTile({
    required String title,
    required Widget icon,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: icon,
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
