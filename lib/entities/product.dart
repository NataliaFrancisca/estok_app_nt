class Product{
  int id;
  int estoque_id;
  String nome;
  String descricao;
  String imagem;
  double valor_item;
  double valor_unitario;
  int quantidade;
  String site;

  Product({
    this.id,
    this.estoque_id,
    this.nome,
    this.descricao,
    this.imagem,
    this.valor_item,
    this.valor_unitario,
    this.quantidade,
    this.site
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: (json['id'] != null) ? (json['id'] as num).toInt() : null,
      estoque_id: (json['estoque_id'] != null) ? (json['estoque_id'] as num).toInt() : null,
      nome: (json['nome'] as String),
      descricao: (json['descricao'] as String),
      imagem: (json['imagem'] as String),
      valor_item: (json['valor_item'] != null) ? (json['valor_item'] as num).toDouble() : null,
      valor_unitario: (json['valor_unitario'] != null) ? (json['valor_unitario'] as num).toDouble() : null,
      quantidade: (json['quantidade'] != null) ? (json['quantidade'] as num).toInt() : null,
      site: (json['site'] as String),
    );
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      "id": this.id,
      "estoque_id": this.estoque_id,
      "nome": this.nome,
      "descricao": this.descricao,
      "imagem": this.imagem,
      "valor_item": this.valor_item,
      "valor_unitario": this.valor_unitario,
      "quantidade": this.quantidade,
      "site": this.site
    };
  }

  Map<String, dynamic> toJsonRequest(){
    return <String, dynamic>{
      "nome": this.nome,
      "descricao": this.descricao,
      "imagem": this.imagem,
      "valor_item": this.valor_item,
      "valor_unitario": this.valor_unitario,
      "quantidade": this.quantidade,
      "site": this.site
    };
  }

  factory Product.clone(Product product) {
      return Product(
        id: product.id,
        estoque_id: product.estoque_id,
        nome: product.nome,
        descricao: product.descricao,
        imagem: product.imagem,
        valor_item: product.valor_item,
        valor_unitario: product.valor_unitario,
        quantidade: product.quantidade,
        site: product.site
      );
    }

}
