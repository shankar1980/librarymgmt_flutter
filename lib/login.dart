import 'package:flutter/material.dart';
import 'package:librarymgmt/auth_provider.dart';
import 'package:librarymgmt/home.dart';
import 'package:librarymgmt/model/user_model.dart';
import 'package:librarymgmt/service/library_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    final navState = Navigator.of(context);

    void login() async {
      var signedIn =
          await authState.login(emailController.text, passwordController.text);
      if (signedIn) {
        navState
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter email'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter password'),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
