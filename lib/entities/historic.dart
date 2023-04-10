enum Action{
  add,
  update,
  delete,
}

class Historic{
  int id;
  String name;
  String date;
  String type; // produto ou stock
  String action;

  Historic({
    this.id,
    this.name,
    this.date,
    this.type,
    this.action
  });

  factory Historic.fromJson(Map<String, dynamic> json){
    return new Historic(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String),
      date: (json['date'] as String),
      type: (json['type'] as String),
      action: (json['action'] as String)
    );
  }

  Map<String, dynamic> toJson(){
    return<String, dynamic>{
      'id': this.id,
      'name': this.name,
      'date': this.date,
      'type': this.type,
      'action': this.action
    };
  }

}

