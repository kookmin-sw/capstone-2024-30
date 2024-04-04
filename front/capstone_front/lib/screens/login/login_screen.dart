import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _userInfo = ['', ''];
  bool _canLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('login'),
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
                    child: loginTextField(context, tr("kmu_email"), 0, false),
                  ),
                  const Text("@kookmin.ac.kr"),
                ],
              ),
              loginTextField(context, tr("password"), 1, true),
              Row(
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () async {
                        String result = await _login(
                            '${_userInfo[0]}@kookmin.ac.kr', _userInfo[1]);
                        switch (result) {
                          case "success":
                            makeToast("로그인에 성공하였습니다");
                            await storage.write(key: 'isLogin', value: 'true');
                            await storage.write(
                                key: 'userEmail',
                                value: '${_userInfo[0]}@kookmin.ac.kr');
                            context.go('/');
                          case "email":
                            makeToast("이메일이 인증되지 않았습니다");
                          case "invalid-credential":
                            makeToast("아이디 또는 비밀번호가 일치하지 않습니다");
                          default:
                            makeToast("로그인 실패");
                        }
                      },
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          color: _canLogin
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            tr('login'),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        context.push('/login/signup');
                      },
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            tr('signup'),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
          _checkCanLogin();
        });
      },
    );
  }

  void _checkCanLogin() {
    for (int i = 0; i < _userInfo.length; i++) {
      if (_userInfo[i] == '') {
        _canLogin = false;
        return;
      }
    }
    _canLogin = true;
  }

  Future<String> _login(String email, String pw) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);

      user = credential.user;
      await user!.reload();
      user = _auth.currentUser;

      if (user!.emailVerified) {
        user = credential.user;
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
}
