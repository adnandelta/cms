import 'package:firebase_auth/firebase_auth.dart';
import 'package:cms/Models/user_model.dart';
import 'package:cms/Services/database.dart';

class AuthService {
  final FirebaseAuth _authObj = FirebaseAuth.instance;

  UserModel _fireToUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _authObj.authStateChanges().map(_fireToUser);
  }

  // Signou

  Future signOutAnon() async {
    try {
      await _authObj.signOut();
    } catch (e) {
      print("Unable");
    }
  }

  Future emailRegister(String email, String pass) async {
    try {
      UserCredential result = await _authObj.createUserWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData("No-name", "CSE", "First", "A", "test@gmail.com", 69);
      return _fireToUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

// Email and Password Functions
  Future emailSignIn(String email, String pass) async {
    try {
      UserCredential result = await _authObj.signInWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user;
      return _fireToUser(user);
    } catch (e) {}
  }

  Future signOut() async {
    try {
      return await _authObj.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
