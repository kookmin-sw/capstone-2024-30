import 'dart:convert';
import 'dart:ui';

import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/screens/signup/college_department.dart';
import 'package:capstone_front/screens/signup/signup_email_screen.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/screens/signup/singup_password_screen.dart';
import 'package:capstone_front/services/auth_service.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Map<String, String> userInfo = {
  'uuid': '',
  'id': '',
  'pw': '',
  'pwRe': '',
  'studentNum': '',
  'college': '',
  'department': '',
  'country': '',
};
int selectedPageIndex = 0;

Future<String> signup() async {
  Map<String, dynamic> userData = {
    'uuid': userInfo['uuid'],
    'email': "${userInfo['id']}@kookmin.ac.kr",
    'name': 'messi',
    'country': userInfo['country'],
    'phoneNumber': '010-8276-8291',
    'major': userInfo['department'],
  };

  var isSucceed = await AuthService.signUp(userData);
  if (isSucceed) {
    return 'success';
  }
  throw Exception('there is something problem while signup');
}

Future<void> sendEmailAuth(String email, String pw) async {
  try {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: '${userInfo['id']}@kookmin.ac.kr',
      password: userInfo['pw']!,
    );
    await credential.user!.sendEmailVerification();

    User? user = credential.user;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;
  } on FirebaseAuthException catch (e) {
    print(e.code);
  }
}

Future<String> isEmailAuth(String email, String pw) async {
  try {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pw);

    User? user = credential.user;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;

    if (user!.emailVerified) {
      user = credential.user;
      userInfo['uuid'] = user!.uid;
      return "success";
    } else {
      return "email";
    }
  } on FirebaseAuthException catch (e) {
    print(e.code);
    return e.code;
  }
}

void makeToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    fontSize: 20,
  );
}
