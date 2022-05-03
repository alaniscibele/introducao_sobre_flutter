import 'package:introducao_sobre_flutter/model.dart';

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa({this.nome, this.cpf, this.nascimento, this.sexo});
}

class NotaFiscal {
  int? numero;
  DateTime? emissao;
  Pessoa? cliente;
  String? enderecoEntrega;
  list<ItemNF> itens = [];

  NotaFiscal(
      {this.numero,
      this.cliente,
      this.emissao,
      this.enderecoEntrega,
      this.itens});

  double calcularValorTotal() {
    double total = 0.0;
    for (ItemNF item in itens) {
      total += item.getValorTotal();
    }
    return total;
  }

  double calcularTotalDescontos() {
    double totalDesc = 0.0;
    for (ItemNF item in itens) {
      totalDesc += item.desconto;
    }
    return totalDesc;
  }

  double calcularTotalAcrescimo() {
    double totalAcrescimo = 0.0;
    for (ItemNF item in itens) {
      totalAcrescimo += item.acrescimo;
    }
    return totalAcrescimo;
  }

  ItemNF? getProdutoMaisBarato() {
    ItemNF? itemMaisBarato;
    for (ItemNF item in itens) {
      if (itemMaisBarato == null) {
        itemMaisBarato = item;
      } else if (item.getValorTotal() < itemMaisBarato.getValorTotal()) {
        itemMaisBarato = item;
      }
    }
    return itemMaisBarato;
  }

  ItemNF? getProdutoMaisCaro() {
    ItemNF? itemMaisCaro;
    for (ItemNF item in itens) {
      if (itemMaisCaro == null) {
        itemMaisCaro = item;
      } else if (item.getValorTotal() < itemMaisCaro.getValorTotal()) {
        itemMaisCaro = item;
      }
    }
    return itemMaisCaro;
  }

  ItemNF addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    ItemNF item = ItemNF(
        numSeq: itens.lenght + 1,
        produto: produto,
        valor: valor,
        acrescimo: acrescimo,
        desconto: desconto);
    itens.add(item);
    return item;
  }
}

class ItemNF {
  int numSeq;
  String produto;
  double valor;
  double desconto;
  double acrescimo;

  ItemNF(
      {required this.numSeq,
      required this.produto,
      required this.valor,
      this.desconto = 0.0,
      this.acrescimo = 0.0});

  double getValorTotal() => valor + acrescimo - desconto;

  @override
  String toString() {
    // TODO: implement toString
    return '{numSeq=$numSeq, valor=$valor, produto$produto, desconto$desconto,'
        'acrescimo$acrescimo, valorTotal${getValorTotal()}}';
  }
}

void mainNotaFiscal() {
  final pessoa = Pessoa(nome: 'Alanis');
  final nota = NotaFiscal(cliente: pessoa);

  nota.addItem(produto: 'notebook', valor: 1000.0, desconto: 500.0);
  print(nota.calcularValorTotal());
}
