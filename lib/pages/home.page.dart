import 'package:flutter/material.dart';
import 'package:growdev_desafio_fase2/models/lista.model.dart';
import 'package:growdev_desafio_fase2/pages/lista.page.dart';
import 'package:growdev_desafio_fase2/pages/produto.page.dart';
import 'package:growdev_desafio_fase2/widgets/empty-list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Lista> listas = [];

  deleteList(int index) {
    setState(() => listas.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Minhas listas",
          key: Key("appBarTitle"),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.diamond,
              color: Colors.amber,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: (listas.isEmpty)
            ? const EmptyList()
            : ListView.builder(
                itemCount: listas.length,
                itemBuilder: (ctx, index) {
                  final Lista lista = listas[index];
                  return Card(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: InkWell(
                      key: const Key("shoppingListCard"),
                      onLongPress: () => deleteList(index),
                      onTap: () async {
                        var response = await Navigator.of(ctx).push(
                          MaterialPageRoute(
                            builder: (ctx) => ProdutoPage(lista: lista),
                          ),
                        );

                        setState(() {
                          if (response != null) {
                            lista.produtos.clear();
                            lista.produtos.addAll(response.produtos);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(lista.descricao),
                                Text(
                                  "${lista.qtdProdutosConcluidos}/${lista.qtdProdutos}",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearProgressIndicator(
                              value: (lista.qtdProdutos == 0)
                                  ? 0
                                  : lista.qtdProdutosConcluidos /
                                      lista.qtdProdutos,
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: () async {
          var novaLista = await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const ListaPage()),
          );
          if (novaLista != null) {
            setState(() {
              listas.add(novaLista);
            });
          }
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(90)),
        ),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
