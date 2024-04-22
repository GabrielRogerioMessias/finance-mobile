class Dispesa {
  final int? dispesa_id;
  final int userId;
  final int categoriaId;
  final DateTime dataDespesa;
  final double valorDespesa;

  Dispesa({
    required this.userId,
    required this.categoriaId,
    required this.dataDespesa,
    required this.valorDespesa,
    this.dispesa_id,
  });

  factory Dispesa.fromJson(Map<String, dynamic> json) => Dispesa(
    dispesa_id: json['dispesa_id'],
    userId: json['userId'],
    categoriaId: json['categoriaId'],
    dataDespesa: DateTime.parse(json['data_despesa']),
    valorDespesa: json['valor_despesa'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dispesa_id': dispesa_id,
    'userId': userId,
    'categoriaId': categoriaId,
    'data_despesa': dataDespesa.toIso8601String(),
    'valor_despesa': valorDespesa,
  };
}
