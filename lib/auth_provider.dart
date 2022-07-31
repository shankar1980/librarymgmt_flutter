import 'package:flutter/material.dart';
import 'package:librarymgmt/model/user_model.dart';
import 'package:librarymgmt/service/library_service.dart';

class AuthProvider extends ChangeNotifier {
  final LibraryService _libraryService = LibraryService();
  bool isAuthenticated = false;
  User? user;

  User? get loginUser => user;

  Future<bool> login(String email, String password) async {
    user = await _libraryService.login(email, password);
    isAuthenticated = true;
    notifyListeners();
    return isAuthenticated;
  }

  Future logout() async {
    isAuthenticated = false;
  }
}
