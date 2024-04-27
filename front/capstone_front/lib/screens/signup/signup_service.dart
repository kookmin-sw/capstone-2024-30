import 'dart:ui';

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

late UserCredential credential;

Map<String, String> userInfo = {
  'id': '',
  'pw': '',
  'pwRe': '',
  'name': '',
  'studentNum': '',
  'college': '',
  'department': '',
  'country': '',
};
int selectedPageIndex = 0;

Future<String> signup() async {
  try {
    // UserCredential credential =
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: '${userInfo['id']}@kookmin.ac.kr',
    //   password: userInfo['pw']!,
    // );
    // await credential.user!.sendEmailVerification();

    // TODO 우리 서버에 signup 요청 여기서
    // signupInfo 에는 실제 유저에게 입력받은 정보가 들어가야함

    // final Map<String, dynamic> signupInfo = {
    //   // "uuid": credential.user!.uid,
    //   "uuid": 'messi',
    //   "email": 'jihunchoi@kookmin.ac.kr',
    //   "name": 'jihun',
    //   "country": 'korea',
    //   "phoneNumber": '010-8276-8291',
    //   "major": "sw",
    // };
    // var response = AuthService.signUp(signupInfo);

    // response의 결과에 따라 성공, 실패, 이유 띄워야함

    return 'success';
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    return e.toString();
  }
}

Future<String> sendEmailAuth(String email, String pw) async {
  try {
    credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: '${userInfo['id']}@kookmin.ac.kr',
      password: userInfo['pw']!,
    );

    await credential.user?.sendEmailVerification();

    return "success";
  } on FirebaseAuthException catch (e) {
    return e.code;
  }
}

Future<String> isEmailAuth(String email, String pw) async {
  try {
    // UserCredential credential = await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: email, password: pw);

    // User? user = credential.user;
    // await user!.reload();
    // user = FirebaseAuth.instance.currentUser;
    if (credential.user!.emailVerified) {
      // user = credential.user;
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
