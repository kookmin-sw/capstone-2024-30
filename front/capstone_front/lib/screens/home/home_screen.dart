import 'package:capstone_front/screens/cafeteriaMenu/cafeteriaMenuScreen.dart';
import 'package:capstone_front/screens/notice/notice_screen.dart';
import 'package:capstone_front/services/login_service.dart';
import 'package:capstone_front/utils/white_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:restart_app/restart_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        title: const Text(
          "외국민",
          style: TextStyle(
              fontFamily: "soojin",
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w300),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              showSetting(context);
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Transform.translate(
                          offset: const Offset(0, -80),
                          child: Column(
                            children: [
                              WhiteBox(
                                content: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "김민제",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Text("소프트웨어융합대학 소프트웨어학부"),
                                    Text(
                                      "20191557",
                                      style:
                                          TextStyle(color: Color(0xFF979797)),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              WhiteBox(
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(tr("mainScreen.notice"),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const NoticeScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              WhiteBox(
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(tr("mainScreen.cafeteria"),
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CafeteriaMenuScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "김치찌개",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "밥",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "짜장면",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "얼큰국밥",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      "고치돈",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     MenuButton(
                              //       title: tr("mainScreen.notice"),
                              //       icon: Icons.notifications_rounded,
                              //       routeCallbackFun: () => context.push("/notice"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.cafeteria"),
                              //       icon: Icons.restaurant_menu_rounded,
                              //       routeCallbackFun: () =>
                              //           context.push("/cafeteriamenu"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.school_info"),
                              //       icon: Icons.school_rounded,
                              //       routeCallbackFun: () => context.push("/login"),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     MenuButton(
                              //       title: tr("mainScreen.qna"),
                              //       icon: Icons.question_answer_outlined,
                              //       routeCallbackFun: () =>
                              //           context.push("/qnalist"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.faq"),
                              //       icon: Icons.question_mark_rounded,
                              //       routeCallbackFun: () => context.push("/faq"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.community"),
                              //       icon: Icons.question_answer_rounded,
                              //       routeCallbackFun: () => context.push("/login"),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     MenuButton(
                              //       title: tr("mainScreen.guide"),
                              //       icon: Icons.help_center_rounded,
                              //       routeCallbackFun: () =>
                              //           context.push("/chatbot"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.helper"),
                              //       icon: Icons.person_2_rounded,
                              //       routeCallbackFun: () => context.push("/helper"),
                              //     ),
                              //     MenuButton(
                              //       title: tr("mainScreen.pronunciation_practice"),
                              //       icon: Icons.speaker_group_rounded,
                              //       routeCallbackFun: () =>
                              //           context.push("/pronunciation"),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: InkWell(
              onTap: () {
                context.push('/chatbot');
              },
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 66,
                width: 66,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('assets/images/koomin.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showSetting(BuildContext context) {
    return showModalBottomSheet(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(tr('mainScreen.language_setting')),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Text("\u{1f1f0}\u{1f1f7}"), // 한국어
                        onPressed: () async {
                          await storage.write(key: 'language', value: 'korean');
                          restartDialog(context);
                        },
                      ),
                      IconButton(
                          icon: const Text("\u{1f1fa}\u{1f1f8}"), // 영어
                          onPressed: () async {
                            await storage.write(
                                key: 'language', value: 'english');
                            restartDialog(context);
                          }),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      logout();
                      await storage.write(key: 'isLogin', value: 'true');
                      context.go('/login');
                    },
                    child: Text(tr("mainScreen.logout")),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> restartDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: const Text("언어 변경을 적용하려면 앱을 재시작해야 합니다.\n재시작하시겠습니까?"),
          actions: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("아니요"),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Restart.restartApp(webOrigin: "/");
                },
                child: const Text("네"),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback routeCallbackFun;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.routeCallbackFun,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          width: 90,
          child: InkWell(
            onTap: routeCallbackFun,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-1, 0),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(1, 0),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
