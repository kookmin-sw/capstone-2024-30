import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> login(String email, String pw) async {
  try {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pw);

    User? user = credential.user;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;

    if (user!.emailVerified) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.write(key: 'uuid', value: user.uid);
      return "success";
    } else {
      return "email";
    }
  } on FirebaseAuthException catch (e) {
    print(e.code);
    return e.code;
  }
}

Future logout() async {
  try {
    return await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("logout fail");
    print(e.toString());
    return null;
  }
}
