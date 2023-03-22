class User{
  int id;
  String nome;
  String email;
  String senha;
  String telefone;
  String token;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.telefone,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: (json['id'] != null) ? (json['id'] as num).toInt() : null,
      nome: (json["nome"] as String),
      email: (json["email"] as String),
      senha: (json["senha"] as String),
      telefone: (json["telefone"] as String),
      token: (json["token"] as String)
    );
  }

  Map<String, dynamic> toJson(){
    return<String, dynamic>{
      "id": this.id,
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha,
      "telefone": this.telefone,
      "token": this.token
    };
  }
}
