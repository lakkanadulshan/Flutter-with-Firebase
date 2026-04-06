import 'package:brew_crew/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {

  // firebase auth instance
  FirebaseAuth get _auth => FirebaseAuth.instance;

  //create user from uid
   UserModel? _userWithFirebaseUserUid(User? user) {
   return user != null ? UserModel(uid: user.uid) : null;
  }

  //Sign in anonymous
  Future signinanonymous() async{

    try{    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;
    return _userWithFirebaseUserUid(user);
    }catch(error){
      print(error.toString());
      return null;
    }
  }
    // Sign out
  Future signOut() async {
    await _auth.signOut();
  }
  }
  //Signin using email and password
  //Sign in with google
  //Signout
