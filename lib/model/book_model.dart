class Book {
  String? isbn;
  String? title;
  String? author;
  String? publisher;
  int? pages;
  int? quantity;
  int? available;
  Book(
      {required this.isbn,
      required this.title,
      required this.author,
      required this.publisher,
      required this.pages,
      required this.quantity,
      required this.available});

  Book.fromJson(Map<String, dynamic> json) {
    isbn = json['isbn'];
    title = json['title'];
    author = json['author'];
    publisher = json['publisher'];
    pages = json['pages'];
    quantity = json['quantity'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isbn'] = isbn;
    data['title'] = title;
    data['author'] = author;
    data['publisher'] = publisher;
    data['pages'] = pages;
    data['quantity'] = quantity;
    data['available'] = available;
    return data;
  }
}
