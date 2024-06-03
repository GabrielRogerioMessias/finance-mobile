class Transacao {
  final int transacaoId;
  final int userId;
  final int? categoriaId;
  final String dataEntrada;
  final double valorEntrada;
  final String descricao;
  final bool tipoTransacao;

  Transacao({
    required this.transacaoId,
    required this.userId,
    this.categoriaId,
    required this.dataEntrada,
    required this.valorEntrada,
    required this.descricao,
    required this.tipoTransacao,
  });


  factory Transacao.fromMap(Map<String, dynamic> map) {
    if (map['transacao_id'] is int) {
      return Transacao(
        transacaoId: map['transacao_id'].toInt(),
        userId: map['userId'] as int,
        categoriaId: map['categoriaId'] as int?,
        dataEntrada: map['data_entrada'] as String,
        valorEntrada: map['valor_entrada'] as double,
        descricao: map['descricao'] as String,
        tipoTransacao: map['tipo_transacao'] == 1,
      );
    } else {
      throw Exception('Erro na conversão de dados da transação');
    }
  }
  Map<int, String> categoriasNome = {
    1: 'Alimentação',
    2: 'Compras',
    3: 'Contas',
    4: 'Salário',
    5: 'Pix',
  };


}

