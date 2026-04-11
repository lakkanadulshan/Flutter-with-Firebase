import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // await AuthServices().signout();
              await _auth.signout();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: const Center(
        child: Text('welcome to HOME'),
      ),
    );
  }
}