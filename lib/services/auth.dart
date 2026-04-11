import 'package:brew_crew/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {

  // firebase auth instance
  FirebaseAuth get _auth => FirebaseAuth.instance;

  //create user from uid
   UserModel? _userWithFirebaseUserUid(User? user) {
   return user != null ? UserModel(uid: user.uid) : null;
  }

  //create a stream of user auth changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
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
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  //Signin using email and password
  //Sign in with google
  //Signout
}