import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authentication/authentication.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/UserModel.dart';

 

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //access the user from provider and decide which screen to show
    final user = Provider.of<UserModel?>(context);
    
    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}