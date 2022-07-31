import 'package:flutter/material.dart';
import 'package:librarymgmt/auth_provider.dart';
import 'package:librarymgmt/book_count.dart';
import 'package:librarymgmt/book_list.dart';
import 'package:librarymgmt/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, auth, child) => MaterialApp(
              title: 'Library Management',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: auth.isAuthenticated
                  ? (auth.loginUser!.role == 'admin'
                      ? const BookCountPage()
                      : const BookListPage())
                  : const LoginPage(),
            ));
  }
}
