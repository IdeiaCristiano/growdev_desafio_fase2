import 'package:flutter/material.dart';
import 'package:growdev_desafio_fase2/models/produto.model.dart';

class AddItem extends StatefulWidget {
  // static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    confirmar() {
      if (!formKey.currentState!.validate()) return;

      double valor = 0;
      if (valorController.text.isNotEmpty) {
        valor = double.parse(valorController.text);
      }

      Produto produto =
          Produto(descricao: descricaoController.text, valor: valor);
      Navigator.of(context).pop(produto);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Adicionar Item",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(
            height: 0,
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const Key("inputItem"),
                  controller: descricaoController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? "Campo obrigatório"
                      : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nome do item",
                  ),
                ),
                TextFormField(
                  key: const Key("inputValue"),
                  controller: valorController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "R\$ 0,00",
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              key: const Key("addItemBtn"),
              onPressed: confirmar,
              child: const Text(
                "Adicionar",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
