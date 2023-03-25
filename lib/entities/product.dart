class Product{
  int id;
  int estoque_id;
  String nome;
  String descricao;
  String image;
  double valor_item;
  double valor_unitario;
  int quantidade;
  String site;

  Product({
    this.id,
    this.estoque_id,
    this.nome,
    this.descricao,
    this.image,
    this.valor_item,
    this.valor_unitario,
    this.quantidade,
    this.site
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: (json['id'] as num).toInt(),
      estoque_id: (json['estoque_id'] as num).toInt(),
      nome: (json['nome'] as String),
      descricao: (json['descricao'] as String),
      image: (json['image'] as String),
      valor_item: (json['valor_item'] as num).toDouble(),
      valor_unitario: (json['valor_unitario'] as num).toDouble(),
      quantidade: (json['quantidade'] as num).toInt(),
      site: (json['site'] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      "id": this.id,
      "estoque_id": this.estoque_id,
      "nome": this.nome,
      "descricao": this.descricao,
      "image": this.image,
      "valor_item": this.valor_item,
      "valor_unitario": this.valor_unitario,
      "quantidade": this.quantidade,
      "site": this.site
    };
  }

}
