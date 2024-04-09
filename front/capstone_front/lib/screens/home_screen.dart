import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Our App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
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
                await storage.write(key: 'language', value: 'english');
                restartDialog(context);
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("공지사항",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        Icon(
                          Icons.add,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 ...",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuButton(
                      title: tr("mainScreen.notice"),
                      icon: Icons.notifications_rounded,
                      routeCallbackFun: () => context.push("/notice"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.cafeteria"),
                      icon: Icons.restaurant_menu_rounded,
                      routeCallbackFun: () => context.push("/cafeteriamenu"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.school_info"),
                      icon: Icons.school_rounded,
                      routeCallbackFun: () => context.push("/login"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuButton(
                      title: tr("mainScreen.qna"),
                      icon: Icons.question_answer_outlined,
                      routeCallbackFun: () => context.push("/qnalist"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.faq"),
                      icon: Icons.question_mark_rounded,
                      routeCallbackFun: () => context.push("/login"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.community"),
                      icon: Icons.question_answer_rounded,
                      routeCallbackFun: () => context.push("/login"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuButton(
                      title: tr("mainScreen.guide"),
                      icon: Icons.help_center_rounded,
                      routeCallbackFun: () => context.push("/chatbot"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.helper"),
                      icon: Icons.person_2_rounded,
                      routeCallbackFun: () => context.push("/helper"),
                    ),
                    MenuButton(
                      title: tr("mainScreen.pronunciation_practice"),
                      icon: Icons.speaker_group_rounded,
                      routeCallbackFun: () => context.push("/pronunciation"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
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
        }));
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
