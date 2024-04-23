class Usuario {
  String nome;
  String email;
  String celular;
  String estado;
  String cidade;
  String descricao;
  String senha;
  String fotoPerfil;

  Usuario({
    required this.nome,
    required this.email,
    required this.celular,
    required this.estado,
    required this.cidade,
    required this.descricao,
    required this.senha,
    required this.fotoPerfil,
  });

  // Método para criar um usuário a partir de um mapa (JSON)
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      celular: json['celular'] ?? '',
      estado: json['estado'] ?? '',
      cidade: json['cidade'] ?? '',
      descricao: json['descricao'] ?? '',
      senha: json['senha'] ?? '',
      fotoPerfil: json['fotoPerfil'] ?? '',
    );
  }

  // Método para converter o usuário para um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'celular': celular,
      'estado': estado,
      'cidade': cidade,
      'descricao': descricao,
      'senha': senha,
      'fotoPerfil': fotoPerfil,
    };
  }
}
