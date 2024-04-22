class Entrada {
  final int? entrada_id;
  final int userId;
  final int categoriaId;
  final DateTime dataEntrada;
  final double valorEntrada;
  final String descricaoEntrada;

  Entrada({
    required this.userId,
    required this.categoriaId,
    required this.dataEntrada,
    required this.valorEntrada,
    required this.descricaoEntrada,
    this.entrada_id,
  });

  factory Entrada.fromJson(Map<String, dynamic> json) => Entrada(
    entrada_id: json['entrada_id'],
    userId: json['userId'],
    categoriaId: json['categoriaId'],
    dataEntrada: DateTime.parse(json['data_entrada']),
    valorEntrada: json['valor_entrada'].toDouble(),
    descricaoEntrada: json['descricao_entrada'],
  );

  Map<String, dynamic> toJson() => {
    'entrada_id': entrada_id,
    'userId': userId,
    'categoriaId': categoriaId,
    'data_entrada': dataEntrada.toIso8601String(),
    'valor_entrada': valorEntrada,
    'descricao_entrada': descricaoEntrada,
  };
}
