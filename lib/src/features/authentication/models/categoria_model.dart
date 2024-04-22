class Categoria {
  final int? categoria_id;
  final int userId;
  final String name;

  Categoria({required this.userId, required this.name, this.categoria_id});

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    categoria_id: json['categoria_id'],
    userId: json['userId'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'categoria_id' : categoria_id,
    'userId' : userId,
    'name' : name,
  };
}
