import 'package:flutter/material.dart';
import 'package:librarymgmt/auth_provider.dart';
import 'package:librarymgmt/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const HomePage(),
  ));
}
