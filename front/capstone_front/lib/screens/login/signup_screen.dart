import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final List<String> _userInfo = ['', ''];
  bool _canSignup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Flexible(
                    child: loginTextField(context, "국민대 이메일", 0, false),
                  ),
                  const Text("@kookmin.ac.kr"),
                ],
              ),
              loginTextField(context, "비밀번호", 1, true),
              InkWell(
                onTap: () async {
                  if (_canSignup) {
                    String result = await _signup();
                    switch (result) {
                      case "success":
                        context.go('/');
                        makeToast("인증메일이 발송되었습니다");
                      case "weak-password":
                        makeToast("비밀번호가 너무 짧습니다");
                      case "emil-already-in-use":
                        makeToast("이미 사용된 이메일입니다");
                      default:
                        makeToast("에러: $result");
                    }
                  }
                },
                child: Ink(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _canSignup ? Colors.blue : const Color(0xffd2d7dd),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '이메일 인증 받기',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField loginTextField(
      BuildContext context, String label, int index, bool isObscure) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFFB4B9C3),
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (text) {
        setState(() {
          _userInfo[index] = text;
          _checkCanSignup();
        });
      },
    );
  }

  void _checkCanSignup() {
    for (int i = 0; i < _userInfo.length; i++) {
      if (_userInfo[i] == '') {
        _canSignup = false;
        return;
      }
    }
    _canSignup = true;
  }

  Future<String> _signup() async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '${_userInfo[0]}@kookmin.ac.kr',
        password: _userInfo[1],
      );
      await credential.user!.sendEmailVerification();
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  void makeToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 20,
    );
  }
}
