import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

class SearchMainPage extends StatelessWidget {
  const SearchMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _toolBar(),
            _results(),
          ],
        ),
      ),
    );
  }

  Widget _toolBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: kToolbarHeight * 2.2,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 237, 237),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Solicitudes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: InputWidget(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Buscar',
                  icon: const Icon(Icons.search_outlined),
                ),
              ),
              
              Expanded(
                flex: 1,
                child: IconButtonWidget(
                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                  borderRadius: BorderRadius.circular(borderRadius()),
                  shape: BoxShape.rectangle,
                  iconData: Icons.filter_list,))
            ],
          )
        ],
      ),
    );
  }

  Widget _results() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Resultados',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          _itemResult('A'),
          _itemResult('P'),
          _itemResult('M'),
          _itemResult('A'),
        ],
      ),
    );
  }

  Widget _itemResult(String state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: primaryColor(),
                    borderRadius: BorderRadius.circular(borderRadius())),
                child: Center(child: Text(
                  state
                )),
              )),
          Expanded(flex: 1, child: Container()),
          const Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text('30/04/24'), Text('S/ 300')],
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
