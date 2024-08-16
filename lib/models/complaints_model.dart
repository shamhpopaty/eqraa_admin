class Complaints_Model {
  int? id;
  String? content;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Complaints_Model(
      {this.id, this.content, this.userId, this.createdAt, this.updatedAt});

  Complaints_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
