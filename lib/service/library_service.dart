import 'package:dio/dio.dart';
import 'package:librarymgmt/model/book_count.dart';
import 'package:librarymgmt/model/book_model.dart';
import 'package:librarymgmt/model/lend_model.dart';
import 'package:librarymgmt/model/user_model.dart';
import 'package:librarymgmt/service/api_manager.dart';

class LibraryService {
  late final ApiManager apiManager = ApiManager();

  Future<User> login(String email, String password) async {
    try {
      User user = User(email: email, password: password);
      final response =
          await apiManager.post("/user/login", data: user.toJson());
      user = User.fromJson(response.data);
      return user;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Book>> getBookList() async {
    try {
      final response = await apiManager.get("/book/getBooks");
      final books = (response.data['content'] as List)
          .map((e) => Book.fromJson(e))
          .toList();
      return books;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Book>> searchBooks(String title) async {
    try {
      final response = await apiManager
          .get("/book/search", queryParameters: {'title': title});
      final books = (response.data['content'] as List)
          .map((e) => Book.fromJson(e))
          .toList();
      return books;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<BookCount>> countBookList() async {
    try {
      final response = await apiManager.get("/book/count");
      final bookCnt =
          (response.data as List).map((e) => BookCount.fromJson(e)).toList();
      return bookCnt;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Book>> lendRequest(String isbn) async {
    try {
      var payload = {'isbn': isbn, 'quantity': 1};
      final lendResponse =
          await apiManager.post("/lend/request", data: payload);
      if (lendResponse.statusCode != 200) {
        return lendResponse.data;
      }

      final response = await apiManager.get("/book/getBooks");
      final books = (response.data['content'] as List)
          .map((e) => Book.fromJson(e))
          .toList();
      return books;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Lend>> getLendList() async {
    try {
      final response = await apiManager.get("/lend/getLendDetails");
      final lends =
          (response.data as List).map((e) => Lend.fromJson(e)).toList();
      return lends;
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Lend>> approveLend(int id) async {
    try {
      await apiManager.put("/lend/request/approve/$id");
      return getLendList();
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Lend>> returnLend(int id) async {
    try {
      await apiManager.put("/lend/request/return/$id");
      return getLendList();
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }

  Future<List<Lend>> cancelLend(int id) async {
    try {
      await apiManager.put("/lend/request/cancel/$id");
      return getLendList();
    } on DioError catch (e) {
      final errorMessage = e.error.toString();
      throw errorMessage;
    }
  }
}
