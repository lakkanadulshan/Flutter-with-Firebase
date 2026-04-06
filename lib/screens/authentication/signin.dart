import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  //ref for AuthServices class
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: ElevatedButton(
        onPressed: () async{
          await _auth.signOut();
          dynamic result = await _auth.signinanonymous();
          if(result == null){
            print('Error signing in');
          }else{
            print('Signed in successfully');
            print(result.uid);
            
          }
        }, 
        child: const Text('Sign in Anonymously')),
    );
  }
}