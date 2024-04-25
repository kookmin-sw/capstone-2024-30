import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupEmailAuthScreen extends StatefulWidget {
  const SignupEmailAuthScreen({super.key});

  @override
  State<SignupEmailAuthScreen> createState() => _SignupEmailAuthScreenState();
}

class _SignupEmailAuthScreenState extends State<SignupEmailAuthScreen> {
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
              tr('signup.auth_email'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text('${tr('signup.kmu_email')}: ${userInfo['id']}@kookmin.ac.kr'),
            const SizedBox(height: 10),
            Text(tr('signup.detail_auth_email')),
            const Spacer(),
            BasicButton(
                text: tr('signup.next'),
                onPressed: () async {
                  String result = await isEmailAuth(
                      '${userInfo['id']}@kookmin.ac.kr', userInfo['pw']!);
                  print(result);
                  if (result == "success") {
                    context.push('/signup/college');
                  } else {
                    makeToast("이메일이 인증되지 않았습니다");
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
