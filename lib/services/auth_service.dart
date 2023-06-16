import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:oyuncak_takasi/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  User? get currentUser => _auth.currentUser; // added this line

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      _logger.e(error.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // E-posta doğrulama e-postası gönderme
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return user;
    } catch (error) {
      _logger.e(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String username, String photoUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // E-posta doğrulama e-postası gönderme
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      // Firestore'da yeni bir kullanıcı oluşturma
      if (user != null) {
        await UserService().createUser(
          user.uid,
          {
            'username': username,
            'email': email,
            'photoUrl': photoUrl,
            'id': user.uid,
          },
        );
      }

      return user;
    } catch (error) {
      _logger.e(error.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      _logger.e(error.toString());
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      _logger.e(error.toString());
      return null;
    }
  }
}
