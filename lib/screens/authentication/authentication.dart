import 'package:brew_crew/screens/authentication/signin.dart';
import 'package:brew_crew/screens/authentication/register.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool signInPage = true;

  void switchPages() {
    setState(() {
      signInPage = !signInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signInPage) {
      return SignIn(toggle: switchPages);
    } else {
      return Register(toggle: switchPages);
    }
  }
}
