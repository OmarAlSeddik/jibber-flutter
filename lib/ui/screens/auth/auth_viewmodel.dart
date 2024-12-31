import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jibber/core/models/user_model.dart';

class AuthScreenViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _createOrUpdateUserInFirestore(user);
      }
      return user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> _createOrUpdateUserInFirestore(User user) async {
    final DocumentReference userDoc =
        _firestore.collection('users').doc(user.uid);

    final userSnapshot = await userDoc.get();
    if (!userSnapshot.exists) {
      final newUser = UserModel(
        uid: user.uid,
        name: user.displayName,
        imageUrl: user.photoURL,
        lastMessage: null,
        unreadCounter: 0,
      );
      await userDoc.set(newUser.toMap());
    }
  }
}
