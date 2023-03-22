class Stock{
  int id;
  String descricao;
  String data_entrada;
  String data_validade;
  String tipo;
  String status_estoque;


  Stock({
    this.id,
    this.descricao,
    this.data_entrada,
    this.data_validade,
    this.tipo,
    this.status_estoque
  });

  factory Stock.fromJson(Map<String, dynamic> json){
    return Stock(
      id: (json['id'] as num).toInt(),
      descricao: (json['descricao'] as String),
      data_entrada: (json['data_entrada'] as String),
      data_validade: (json['data_validade'] as String),
      tipo: (json['tipo'] as String),
      status_estoque: (json['status_estoque'] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return<String, dynamic>{
      "id": this.id,
      "descricao": this.descricao,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
      "status_estoque": this.status_estoque
    };
  }

}


