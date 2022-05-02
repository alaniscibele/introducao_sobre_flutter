enum Sexo{ MASCULINO, FEMININO}

class Pessoa{
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  int? getIdade() {
    if (nascimento == null){
      return null;
    }
    final hoje = DateTime.now();
    final idade = hoje.difference(nascimento!);
    return idade.inDays ~/ 365;
  }

  @override
  String toString(){
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento"
        "idade: ${getIdade()}, sexo: $sexo";
  }
}

class Programador extends Pessoa{

  double? salario;

  @override
  String toString(){
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento"
        "idade: ${getIdade()}, sexo: $sexo, salario: $salario";
  }
}

void main_Entidades(){
  Programador pessoa = Programador();
  pessoa.nome = "Alanis Cibele";
  pessoa.cpf = "236.556.987-88";
  pessoa.nascimento = DateTime(2004,07,15);
  pessoa.sexo = Sexo.FEMININO;
  pessoa.salario = 10000.0;
  print(pessoa.toString());

}