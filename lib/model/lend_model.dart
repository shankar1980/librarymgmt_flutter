class Lend {
  int? id;
  String? isbn;
  String? title;
  int? quantity;
  String? status;

  Lend(
      {this.id,
      required this.isbn,
      required this.title,
      required this.quantity,
      required this.status});

  Lend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isbn = json['isbn'];
    title = json['title'];
    quantity = json['quantity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isbn'] = isbn;
    data['title'] = title;
    data['quantity'] = quantity;
    data['status'] = status;
    return data;
  }
}
