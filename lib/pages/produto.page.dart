import 'package:flutter/material.dart';
import 'package:growdev_desafio_fase2/models/lista.model.dart';
import 'package:growdev_desafio_fase2/models/produto.model.dart';
import 'package:growdev_desafio_fase2/widgets/AddItem.widget.dart';
import 'package:intl/intl.dart';

class ProdutoPage extends StatefulWidget {
  final Lista lista;
  const ProdutoPage({super.key, required this.lista});

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  var moneyFormat = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
  late Lista listaAux;

  @override
  void initState() {
    super.initState();
    listaAux = Lista(descricao: "aux");
    // listaAux.produtos = [...widget.lista.produtos];
    for (var i = 0; i < widget.lista.qtdProdutos; i++) {
      Produto produto = widget.lista.produtos[i];
      listaAux.produtos.add(Produto(
          descricao: produto.descricao,
          concluido: produto.concluido,
          valor: produto.valor));
    }
  }

  deleteItem(int index) {
    setState(() => listaAux.produtos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            key: const Key("updateListBtn"),
            onPressed: () {
              Navigator.of(context).pop(listaAux);
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Mercado",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black38,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaAux.qtdProdutos,
                itemBuilder: (ctx, index) {
                  Produto produto = listaAux.produtos[index];
                  print(produto.concluido.toString());
                  return Column(
                    children: [
                      InkWell(
                        key: const Key("productCheckbox"),
                        onLongPress: () => deleteItem(index),
                        onTap: () {
                          setState(() {
                            produto.concluido = !produto.concluido;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 10),
                          child: Row(
                            children: [
                              produto.concluido
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: Colors.blue,
                                    ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    produto.descricao,
                                    style: TextStyle(
                                        color: produto.concluido
                                            ? Colors.black38
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              Text(moneyFormat.format(produto.valor)),
                              // Text("R\$ ${produto.valor.toString()}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Não marcados"),
                          Text(
                            moneyFormat.format(listaAux.totalNaoConcluidos),
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Marcados"),
                        Text(
                          moneyFormat.format(listaAux.totalConcluidos ?? 0),
                          style: const TextStyle(
                              color: Colors.green, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        key: const Key("addNewItemBtn"),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () async {
          var response = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // useSafeArea: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              builder: (ctx) {
                return const AddItem();
              });

          if (response != null) {
            setState(() => listaAux.produtos.add(response));
          }
        },
        child: const Text("Adicionar"),
      ),
    );
  }
}
