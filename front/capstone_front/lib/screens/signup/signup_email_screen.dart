import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupEmailScreen extends StatefulWidget {
  const SignupEmailScreen({super.key});

  @override
  State<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends State<SignupEmailScreen> {
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
              tr('signup.enter_kmuemail'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: SignupTextField(
                      context: context,
                      label: tr('signup.kmu_email'),
                      info: 'id',
                      isObscure: false,
                      userInfo: userInfo),
                ),
                const Text("@kookmin.ac.kr"),
              ],
            ),
            const Spacer(),
            BasicButton(
                text: tr('signup.next'),
                onPressed: () {
                  if (userInfo['id'] != '') {
                    context.push('/signup/password');
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
