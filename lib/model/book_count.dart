class BookCount {
  String? title;
  int? quantity;
  BookCount({required this.title, required this.quantity});

  BookCount.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['quantity'] = quantity;
    return data;
  }
}
