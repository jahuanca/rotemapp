import 'package:app_metor/src/login/core/strings.dart';
import 'package:app_metor/src/login/ui/pages/login/login_controller.dart';
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:get/get.dart';
import 'package:utils/utils.dart';

class LoginPage extends StatelessWidget {
  
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final LoginController controller = Get.find();

    return GetBuilder<LoginController>(
      init: controller,
      id: pageId,
      builder: (_) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 242, 242),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.95,
                  child: Column(
                    children: [
                      _topContent(),
                      _contentLogin(_),
                    ],
                  ),
                ),
              ),
              GetBuilder<LoginController>(
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

  Widget _topContent() {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text(
                'METOR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: Image(
                  fit: BoxFit.fill,
                  width: 150,
              image: AssetImage('assets/images/icon_app.png'),
            )))
          ],
        ),
      ),
    );
  }

  Widget _contentLogin(LoginController _) {
    return Expanded(
      flex: 6,
      child: Container(
        
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bienvenido!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Registrate para continuar',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            GetBuilder<LoginController>(
              id: cedulaId,
              builder: (_)=> InputWidget(
                icon: const Icon(Icons.email_outlined),
                padding: const EdgeInsets.symmetric(vertical: 5),
                hintText: 'Cédula',
                onChanged: _.onChangedCedula,
                error: _.errorCedula,
                maxLength: 15,
                textInputType: TextInputType.number,
              ),
            ),
            GetBuilder<LoginController>(
              id: passwordId,
              builder: (_) => PasswordInputWidget(
                  icon: const Icon(Icons.lock_outlined),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  hintText: 'Contraseña',
                  onChanged: _.onChangedPassword,
                  error: _.errorPassword,
                  textInputType: TextInputType.visiblePassword,
                ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Olvidé mi contraseña'),
                  Text('v.1.0.0'),
                ],
              ),
            ),
            ButtonWidget(
              onTap: _.goLogin,
              buttonStyle: ButtonStyle.danger, text: 'Ingresar')
          ],
        ),
      ),
    );
  }
}
