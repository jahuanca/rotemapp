import 'package:app_metor/src/home/ui/pages/main_content/main_content_controller.dart';
import 'package:app_metor/src/aprobar/ui/pages/home_aprobar/home_aprobar_page.dart';
import 'package:app_metor/src/home/ui/pages/home_inicio/home_inicio_page.dart';
import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/settings/ui/pages/home_settings/home_settings_page.dart';
import 'package:app_metor/src/solicitar/ui/pages/home_solicitar/home_solicitar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainContentController>(
      init: MainContentController(),
      id: 'current_page_index',
      builder: (_) => Scaffold(
        body: PageView(
          controller: _.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeInicioPage(),
            if(_.userPreferences.getBool(isAprobadorKey))
            HomeAprobarPage(),
            if(_.userPreferences.getBool(isEmpleadoKey))
            HomeSocilitarPage(),
            const HomeSettingsPage(),
          ],
        ),
        bottomNavigationBar: _bottomNavigation(_),
      ),
    );
  }

  Widget _bottomNavigation(MainContentController controller) {
    return BottomNavigationBar(
        onTap: controller.changePage,
        currentIndex: controller.currentPageIndex,
        selectedItemColor: primaryColor(),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        items: [
          const BottomNavigationBarItem(label: 'Inicio', icon: Icon(Icons.home)),
          if(controller.userPreferences.getBool(isAprobadorKey))
          const BottomNavigationBarItem(label: 'Aprobar', icon: Icon(Icons.list)),
          if(controller.userPreferences.getBool(isEmpleadoKey))
          const BottomNavigationBarItem(
              label: 'Solicitudes', icon: Icon(Icons.checklist_outlined)),

          const BottomNavigationBarItem(label: 'Configuración', icon: Icon(Icons.settings)),
        ]);
  }
}
