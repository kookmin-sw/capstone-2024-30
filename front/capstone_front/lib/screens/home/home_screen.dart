import 'package:capstone_front/main.dart';
import 'package:capstone_front/screens/cafeteriaMenu/cafeteriaMenuScreen.dart';
import 'package:capstone_front/screens/notice/notice_screen.dart';
import 'package:capstone_front/services/login_service.dart';
import 'package:capstone_front/utils/white_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

  Future<Map<String, String>> getUserInfo() async {
    String userName = (await storage.read(key: "userName"))!;
    String userMajor = (await storage.read(key: "userMajor"))!;
    return {"userName": userName, "userMajor": userMajor};
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    return Scaffold(
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
                              FutureBuilder(
                                  future: getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // 데이터 로딩 중인 경우
                                      return WhiteBox(
                                        content: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      // 에러 발생 시
                                      return WhiteBox(
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Error: ${snapshot.error}",
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            const Text(
                                              '',
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      // 데이터 로딩 완료 후
                                      return WhiteBox(
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data!['userName']!,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              snapshot.data!['userMajor']!,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }),
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
                                    menus.cafeteriaMenus.isEmpty ||
                                            menus.cafeteriaMenus[0].isEmpty
                                        ? Center(
                                            child:
                                                Text(tr('mainScreen.no_data')))
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: menus.cafeteriaMenus[0]
                                                .map((data) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[0]),
                                                  Text(data[1]),
                                                  if (data[2] != "0")
                                                    Text('₩${data[2]}'),
                                                  const Text(""),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                  ],
                                ),
                              ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr('mainScreen.language_setting')),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: const Text("\u{1f1f0}\u{1f1f7}"), // 한국어
                        onPressed: () async {
                          await storage.write(key: 'language', value: 'KO');
                          restartDialog(context, "KO");
                        },
                      ),
                      IconButton(
                          icon: const Text("\u{1f1fa}\u{1f1f8}"), // 영어
                          onPressed: () async {
                            await storage.write(
                                key: 'language', value: 'EN-US');
                            restartDialog(context, 'EN-US');
                          }),
                      IconButton(
                          icon: const Text("\u{1F1E8}\u{1F1F3}"), // 중국어
                          onPressed: () async {
                            await storage.write(key: 'language', value: 'ZH');
                            restartDialog(context, 'ZH');
                          }),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(tr('mainScreen.account_setting')),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      logout();
                      await storage.write(key: 'isLogin', value: 'false');
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

  Future<dynamic> restartDialog(BuildContext context, String language) {
    return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: Text(tr("mainScreen.language_setting_notice")),
          actions: [
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(tr("mainScreen.no")),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Restart.restartApp(webOrigin: "/");
                },
                child: Text(tr("mainScreen.yes")),
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
