import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupNameScreen extends StatefulWidget {
  const SignupNameScreen({super.key});

  @override
  State<SignupNameScreen> createState() => _SignupNameScreenState();
}

class _SignupNameScreenState extends State<SignupNameScreen> {
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
              tr('signup.enter_name'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            SignupTextField(
                context: context,
                label: tr('signup.name'),
                info: 'name',
                isObscure: false,
                userInfo: userInfo),
            SignupTextField(
                context: context,
                label: tr('signup.student_number'),
                info: 'studentNum',
                isObscure: false,
                userInfo: userInfo),
            const Spacer(),
            BasicButton(
                text: tr('signup.next'),
                onPressed: () {
                  if (userInfo['name'] != '' && userInfo['studentNum'] != '') {
                    context.push('/signup/college');
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
