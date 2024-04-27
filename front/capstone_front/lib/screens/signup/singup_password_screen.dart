import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPasswordScreen extends StatefulWidget {
  const SignupPasswordScreen({super.key});

  @override
  State<SignupPasswordScreen> createState() => _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends State<SignupPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('signup.enter_password'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            SignupTextField(
                context: context,
                label: tr('signup.password'),
                info: 'pw',
                isObscure: true,
                userInfo: userInfo),
            SignupTextField(
                context: context,
                label: tr('signup.password_re'),
                info: 'pwRe',
                isObscure: true,
                userInfo: userInfo),
            const Spacer(),
            BasicButton(
                text: tr('signup.next'),
                onPressed: () async {
                  if (userInfo['pw'] != userInfo['pwRe']) {
                    makeToast(tr('signup.password_not_same'));
                  } else if (userInfo['pw'] != '') {
                    // 파이어베이스에 계정 생성을 시도하면서 인증 메일 전송
                    String result =
                        await sendEmailAuth(userInfo['id']!, userInfo['pw']!);
                    // 파이어베이스에 계정 생성 완료, 인증 메일 전송 완료
                    if (result == "success") {
                      print(userInfo['id']);
                      print(userInfo['pw']);
                      print(userInfo['name']);
                      print(userInfo['studentNum']);
                      print(userInfo['college']);
                      print(userInfo['department']);
                      print(userInfo['country']);

                      // Todo: 서버로 회원가입된 내역 전송

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(tr('signup.auth_email')),
                          content: Text(tr('signup.detail_auth_email')),
                          actions: [
                            ElevatedButton(
                                onPressed: () => context.go('/login'),
                                child: Text(tr('signup.ok'))),
                          ],
                        ),
                      );
                    }
                    // 파이어베이스에 계정 생성 실패
                    else {
                      if (result == "weak-password") {
                        makeToast(tr('signup.weak_password'));
                      } else if (result == "email-already-in-use") {
                        makeToast(tr('signup.duplicated_email'));
                      }
                    }
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
