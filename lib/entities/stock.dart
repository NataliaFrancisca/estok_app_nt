import 'dart:convert';

class Stock{
  int id;
  String descricao;
  int quantidade_total;
  String data_entrada;
  String data_validade;
  String tipo;
  String status_estoque;


  Stock({
    this.id,
    this.descricao,
    this.quantidade_total,
    this.data_entrada,
    this.data_validade,
    this.tipo,
    this.status_estoque
  });

  factory Stock.fromJson(Map<String, dynamic> json){
    return Stock(
      id: (json['id'] != null) ? (json['id'] as num).toInt() : null,
      descricao: (json['descricao'] as String),
      quantidade_total: (json['quantidade_total'] != null) ? (json['quantidade_total'] as num).toInt() : null,
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
      "quantidade_total": this.quantidade_total,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
      "status_estoque": this.status_estoque
    };
  }

  Map<String, dynamic> toJsonRequest(){
    return<String, dynamic>{
      "descricao": this.descricao,
      "quantidade_total": this.quantidade_total,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
    };
  }

   Map<String, dynamic> toJsonUpdate(){
    return<String, dynamic>{
      "id": this.id,
      "descricao": this.descricao,
      "quantidade_total": this.quantidade_total,
      "data_entrada": this.data_entrada,
      "data_validade": this.data_validade,
      "tipo": this.tipo,
    };
  }

  static Map<String, dynamic> toMap(Stock stock) => {
    "id": stock.id,
    "descricao": stock.descricao,
    "quantidade_total": stock.quantidade_total,
    "data_entrada": stock.data_entrada,
    "data_validade": stock.data_validade,
    "tipo": stock.tipo,
    "status_estoque": stock.status_estoque
  };

  static String encode(List<Stock> listStock){
    return json.encode(
      listStock.map<Map<String, dynamic>>((stock) => Stock.toMap(stock)).toList()
    );
  }

  static List<Stock> decode(String listStock){
    return (json.decode(listStock) as List<dynamic>).map<Stock>((item) => Stock.fromJson(item)).toList();
  }
}


