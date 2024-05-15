import 'package:capstone_front/main.dart';
import 'package:capstone_front/models/notice_response.dart';
import 'package:capstone_front/screens/cafeteriaMenu/cafeteriaMenuScreen.dart';
import 'package:capstone_front/screens/home/image_screen.dart';
import 'package:capstone_front/screens/home/webview_screen.dart';
import 'package:capstone_front/screens/notice/notice_screen.dart';
import 'package:capstone_front/services/login_service.dart';
import 'package:capstone_front/services/notice_service.dart';
import 'package:capstone_front/utils/bubble_painter2.dart';
import 'package:capstone_front/utils/bubble_painter_right.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool _isVisible = true;
  late AnimationController _controller;
  late Future<NoticesResponse> noticesRes;

  @override
  void initState() {
    super.initState();

    noticesRes = NoticeService.getNotices(0, 'all', language);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isVisible = !_isVisible;
          });
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WhiteBox(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      userName,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  userMajor,
                                ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tr("mainScreen.notice"),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    Transform.translate(
                                      offset: Offset(10, -10),
                                      child: IconButton(
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                FutureBuilder(
                                  future: noticesRes,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.notices[0].title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot.data!.notices[1].title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot.data!.notices[2].title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot.data!.notices[3].title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            snapshot.data!.notices[4].title!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tr("mainScreen.cafeteria"),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    Transform.translate(
                                      offset: Offset(10, -10),
                                      child: IconButton(
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                menus.cafeteriaMenus.isEmpty ||
                                        menus.cafeteriaMenus[0].isEmpty
                                    ? Center(
                                        child: Text(tr('mainScreen.no_data')))
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            menus.cafeteriaMenus[0].map((data) {
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
                          const SizedBox(height: 15),
                          WhiteBox(
                              content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr('mainScreen.other_info'),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  MenuButton(
                                      title: tr('mainScreen.shcool_map'),
                                      icon: Icons.map_outlined,
                                      routeCallbackFun: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const ImageScreen(
                                                'assets/images/kookmin_map_row.jpg'),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MenuButton(
                                      title: tr('mainScreen.facility_info'),
                                      icon: Icons.business,
                                      routeCallbackFun: () {
                                        if (language == 'EN-US') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ImageScreen(
                                                      'assets/images/facility_time_en.jpg'),
                                            ),
                                          );
                                        } else if (language == 'ZH') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ImageScreen(
                                                      'assets/images/facility_time_zh.jpg'),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ImageScreen(
                                                      'assets/images/facility_time_ko.jpg'),
                                            ),
                                          );
                                        }
                                      }),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MenuButton(
                                      title: tr('mainScreen.shuttle_info'),
                                      icon: Icons.directions_bus,
                                      routeCallbackFun: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WebViewScreen(
                                                    'https://coss.kookmin.ac.kr/fvedu/intro/shuttle.do'),
                                          ),
                                        );
                                      }),
                                  // MenuButton(
                                  //     title: "챗봇",
                                  //     icon: Icons.chat,
                                  //     routeCallbackFun: () {}),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          Positioned(
            right: 75,
            bottom: 20,
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: CustomPaint(
                painter: BubblePainter2(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    tr("mainScreen.use_chatbot"),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
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
          child: InkWell(
              onTap: routeCallbackFun,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
