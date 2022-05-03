import 'dart:collection';
import 'dart:io';

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
  List<ItemNF> listaItens = [];

  NotaFiscal({this.numero, this.cliente, this.emissao, this.enderecoEntrega});

  double? calcularValorTotal() {
    return listaItens.map((e) => e.getValorTotal()).reduce((a, b) => a + b);
  }

  double? calcularValorTotalDescontos() {
    return listaItens.map((e) => e.getValorTotal()).reduce((a, b) => a - b);
  }

  ItemNF? getProdutoMaisBarato() {
    return listaItens
        .map((e) => e)
        .reduce((a, b) => a.getValorTotal() < b.getValorTotal() ? a : b);
  }

  ItemNF? getProdutoMaisCaro() {
    return listaItens
        .map((e) => e)
        .reduce((a, b) => a.getValorTotal() > b.getValorTotal() ? a : b);
  }

  bool possuiDesconto() {
    return listaItens.map((e) => e).any((c) => c.desconto > 0);
  }

  Iterable<ItemNF> itensComDesconto() {
    return listaItens.map((e) => e).where((c) => c.desconto > 0);
  }

  ItemNF? addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    if (valor == 0.0) {
      throw Exception('Valor não pode ser 0');
    }
    if (produto == '') {
      throw Exception('O produto tem que ser informado!');
    }
    ItemNF item = ItemNF(
        numSeq: listaItens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo);
    listaItens.add(item);
    return item;
  }

  String? getStrItens() {
    return listaItens.map((i) => "${i.numSeq}: ${i.produto}").join(", ");
  }
}

class ItemNF {
  int? numSeq;
  String? produto;
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
    return '{numSeq=$numSeq, produto=$produto, valor=$valor, desconto=$desconto '
        'acrescimo=$acrescimo, valorTotal=${getValorTotal()}}';
  }
}

void mainNotaFiscal() {
  // try {
  final pessoa = Pessoa();
  final nota = NotaFiscal(
      cliente: pessoa,
      emissao: DateTime(2022, 5, 3),
      enderecoEntrega: 'Rua 7 de Setembro',
      numero: 1500);
  nota.addItem(produto: 'Notebook', valor: 1000.0, acrescimo: 100.0);
  nota.addItem(produto: 'Teclado', valor: 200.0, acrescimo: 100.0);

  print('Valor total da NF = ${nota.calcularValorTotal()}');
  print('Valor total da NF = ${nota.getProdutoMaisBarato()}');
  print('Valor total da NF = ${nota.getProdutoMaisCaro()}');
}

// --------------------------EXEMPLOS - EXERCÍCIO-----------------------------

// print(nota.join(" ; "));
//
// ----------------------------------**---------------------------------------
// Set<String> nomes = Set<String>();
// nomes.add("Alanis");
// nomes.add("Amanda");
// nomes.add("Kksxn");
// nomes.add("Camilla");
//
// print(nomes);
// ----------------------------------**---------------------------------------
//
// Set<String> nomes = Set<String>();
// nomes.add("Alanis");
// nomes.add("Amanda");
// nomes.add("Kksxn");
// nomes.add("Camilla");
//
// Set<String> nomes1 = Set<String>();
// nomes1.add("Alanis");
// nomes1.add("Larissa");
// nomes1.add("Kksxn");
// nomes1.add("Anna");
//
// print(nomes);
// print(nomes1);
// print(nomes.intersection(nomes1));
// }
// ----------------------------------**---------------------------------------
//
// Iterable<double> valoresTotais= nota.itens.map((e) => e.getValorTotal());
// final maior = valoresTotais.reduce((v1, v2)=> v1 > v2 ? v1 : v2);
// print(maior);
//
// ----------------------------------**---------------------------------------
