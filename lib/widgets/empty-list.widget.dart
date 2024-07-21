import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "assets/images/lista-de-compras.png",
          height: 100,
          key: const Key("emptyListImage"),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text("Crie sua primeia lista"),
        const Text("Toque no botão azul"),
      ]),
    );
  }
}
