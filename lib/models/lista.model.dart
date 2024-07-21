import 'package:growdev_desafio_fase2/models/produto.model.dart';

class Lista {
  String descricao;
  List<Produto> produtos = [];

  Lista({required this.descricao});

  get qtdProdutos => produtos.length;
  get totalProdutos =>
      produtos.map((item) => item.valor).reduce((a, b) => a + b);

  get produtosConcluidos => produtos.where((i) => i.concluido);
  get qtdProdutosConcluidos => produtosConcluidos.length;
  get totalConcluidos => (qtdProdutosConcluidos == 0)
      ? 0
      : produtosConcluidos.map((item) => item.valor).reduce((a, b) => a + b);

  get produtosNaoConcluidos => produtos.where((i) => !i.concluido);
  get qtdProdutosNaoConcluidos => produtosNaoConcluidos.length;
  get totalNaoConcluidos => (qtdProdutosNaoConcluidos == 0)
      ? 0
      : produtosNaoConcluidos.map((item) => item.valor).reduce((a, b) => a + b);
}
