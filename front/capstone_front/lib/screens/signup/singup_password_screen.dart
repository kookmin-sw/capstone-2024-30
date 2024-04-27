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
                  // Todo: 비밀번호 조건 적용 필요(6자 이상 등)
                  if (userInfo['pw'] != '' &&
                      userInfo['pw'] == userInfo['pwRe']) {
                    await sendEmailAuth(userInfo['id']!, userInfo['pw']!);
                    context.push('/signup/emailAuth');
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
