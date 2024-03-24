import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
              icon: const Text("\u{1f1f0}\u{1f1f7}"), // 한국어
              onPressed: () async {
                await storage.write(key: 'language', value: 'korean');
                restartDialog(context);
              }),
          IconButton(
              icon: const Text("\u{1f1fa}\u{1f1f8}"), // 영어
              onPressed: () async {
                await storage.write(key: 'language', value: 'english');
                restartDialog(context);
              }),
        ],
      ),
      body: Row(
        children: [
          Center(
            child: Text(tr('test')),
          ),
          // 로그인 버튼
          IconButton(
            onPressed: () {
              context.push('/login');
            },
            icon: const Icon(
              Icons.login,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> restartDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: const Text("언어 변경을 적용하려면 앱을 재시작해야 합니다.\n 재시작하시겠습니까?"),
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
