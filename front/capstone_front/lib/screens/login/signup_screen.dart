import 'dart:ui';

import 'package:capstone_front/screens/login/assets/college_department.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final Map<String, String> _userInfo = {
    'id': '',
    'pw': '',
    'pwRe': '',
    'studentNum': '',
  };

  List<String>? collegeList = collegeInfo['korean'];
  List<String>? departmentList = ['학과를 골라주세요'];

  String _college = '';
  String _department = '';
  String _country = '국가를 골라주세요';

  bool _selectCollege = false;
  bool _selectDepartment = false;
  bool _selectCountry = false;

  bool _canSignup = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('signup'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: signupTextField(
                              context, tr('kmu_email'), 'id', false),
                        ),
                        const Text("@kookmin.ac.kr"),
                      ],
                    ),
                    signupTextField(context, tr("password"), 'pw', true),
                    signupTextField(context, tr("password_re"), 'pwRe', true),
                    signupTextField(
                        context, tr("student_number"), 'studentNum', false),

                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 15),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("college"),
                              style: const TextStyle(
                                color: Color(0xFFB4B9C3),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DropdownButton(
                              style: Theme.of(context).textTheme.bodyMedium,
                              isExpanded: true,
                              value: _selectCollege ? _college : null,
                              hint: const Text("대학을 골라주세요"),
                              elevation: 16,
                              items: collegeList!.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              menuMaxHeight: 200,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectCollege = true;
                                  _selectDepartment = false;
                                  _college = value!;
                                  departmentList = departmentInfo['korean']![
                                      collegeList!.indexOf(_college)];
                                  _checkCanSignup();
                                });
                              },
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFB4B9C3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 15),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr("department"),
                              style: const TextStyle(
                                color: Color(0xFFB4B9C3),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DropdownButton(
                              style: Theme.of(context).textTheme.bodyMedium,
                              isExpanded: true,
                              value: _selectDepartment ? _department : null,
                              hint: const Text("학과를 골라주세요"),
                              elevation: 16,
                              items: departmentList!
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              menuMaxHeight: 200,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectDepartment = true;
                                  _department = value!;
                                  _checkCanSignup();
                                });
                              },
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFB4B9C3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                            // exclude: <String>['KN', 'MF'],
                            favorite: <String>['KR', 'US', 'CN', 'JP'],
                            //Optional. Shows phone code before the country name.
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              setState(() {
                                _country = country.name;
                                _selectCountry = true;
                                _checkCanSignup();
                              });
                            },
                            // Optional. Sets the theme for the country list picker.
                            countryListTheme: CountryListThemeData(
                              // Optional. Sets the border radius for the bottomsheet.
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              // Optional. Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                              // Optional. Styles the text in the search field
                              searchTextStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFB4B9C3)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  tr("country"),
                                  style: const TextStyle(
                                    color: Color(0xFFB4B9C3),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _country,
                                  ),
                                  const Icon(Icons.arrow_drop_down_outlined)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),
                    // 회원가입 버튼
                    InkWell(
                      onTap: () async {
                        if (_canSignup) {
                          if (_userInfo['pw'] != _userInfo['pwRe']) {
                            makeToast("비밀번호가 일치하지 않습니다");
                          } else {
                            String result = await _signup();
                            switch (result) {
                              case "success":
                                context.go('/');
                                makeToast("인증메일이 발송되었습니다");
                              case "weak-password":
                                makeToast("비밀번호가 너무 짧습니다");
                              case "email-already-in-use":
                                makeToast("이미 사용된 이메일입니다");
                              default:
                                makeToast("에러: $result");
                            }
                          }
                        }
                      },
                      child: Ink(
                        height: 50,
                        decoration: BoxDecoration(
                          color: _canSignup
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '회원가입',
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
            )
          ],
        ),
      ),
    );
  }

  TextField signupTextField(
      BuildContext context, String label, String info, bool isObscure) {
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
          _userInfo[info] = text;
          _checkCanSignup();
        });
      },
    );
  }

  void _checkCanSignup() {
    for (int i = 0; i < _userInfo.length; i++) {
      if (_userInfo['id'] == '' ||
          _userInfo['pw'] == '' ||
          _userInfo['pwRe'] == '' ||
          _userInfo['studentNum'] == '') {
        _canSignup = false;
        return;
      }
      if (!_selectCollege || !_selectDepartment || !_selectCountry) {
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
        email: '${_userInfo['id']}@kookmin.ac.kr',
        password: _userInfo['pw']!,
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

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
