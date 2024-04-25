import 'package:capstone_front/screens/signup/college_department.dart';
import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/screens/signup/signup_util.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SignupCollegeScreen extends StatefulWidget {
  const SignupCollegeScreen({super.key});

  @override
  State<SignupCollegeScreen> createState() => _SignupCollegeScreenState();
}

class _SignupCollegeScreenState extends State<SignupCollegeScreen> {
  List<String>? collegeList = collegeInfo['korean'];
  List<String>? departmentList = ['학과를 골라주세요'];

  String _college = tr('signup.enter_college');
  String _department = tr('signup.enter_department');

  final bool _selectCollege = false;
  final bool _selectDepartment = false;

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
              tr('signup.enter_college_department'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              tr('signup.college'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: ListView.builder(
                                  itemCount: collegeList!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(collegeList![index]),
                                      onTap: () {
                                        setState(() {
                                          _college = collegeList![index];
                                          _department =
                                              tr('signup.enter_department');
                                          departmentList =
                                              departmentInfo['korean']![index];
                                          context.pop();
                                        });
                                      },
                                    );
                                  }),
                            );
                          });
                    },
                    child: Ink(
                      child: Text(_college),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              tr('signup.department'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: ListView.builder(
                                  itemCount: departmentList!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(departmentList![index]),
                                      onTap: () {
                                        setState(() {
                                          _department = departmentList![index];
                                          context.pop();
                                        });
                                      },
                                    );
                                  }),
                            );
                          });
                    },
                    child: Ink(
                      child: Text(_department),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            BasicButton(
                text: tr('signup.next'),
                onPressed: () {
                  if (_college != tr('signup.enter_college') &&
                      _department != tr('signup.enter_department')) {
                    userInfo['college'] = _college;
                    userInfo['department'] = _department;
                    context.push('/signup/country');
                  }
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
