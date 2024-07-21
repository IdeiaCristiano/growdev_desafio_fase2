import 'package:flutter/material.dart';
import 'package:growdev_desafio_fase2/models/lista.model.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    salvar() {
      if (!formKey.currentState!.validate()) return;

      Lista novaLista = Lista(descricao: textEditingController.text);
      Navigator.of(context).pop(novaLista);
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      key: const Key("listNameInput"),
                      controller: textEditingController,
                      validator: (value) => (value != null && value.isNotEmpty)
                          ? null
                          : "Campo Obrigatório",
                      decoration: const InputDecoration(
                        hintText: "Nome da lista",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 6),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1, color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        key: const Key("backToListsBtn"),
                        child: const Text("Voltar"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 10),
                      child: TextButton(
                        style: OutlinedButton.styleFrom(
                          // side: const BorderSide(width: 1, color: Colors.white),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                        ),
                        key: const Key("createListBtn"),
                        onPressed: salvar,
                        child: const Text("Criar"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
