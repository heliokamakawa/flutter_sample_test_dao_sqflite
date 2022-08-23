class Tarefa {
  final int? id;
  final String nome;
  final String descricao;
  final String dataEntrega;

  Tarefa({this.id,required this.nome,required this.descricao,required this.dataEntrega});
}

// na inserção id pode ser nulo - gerado automaticamente pelo BD