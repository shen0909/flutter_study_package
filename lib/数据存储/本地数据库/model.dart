class Model {
  int? id;
  String? content;

  Model(this.id, this.content);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
  Model.fromJson(Map<String,dynamic> json){
    this.id=json['id'];
    this.content=json['content'];
  }
}
