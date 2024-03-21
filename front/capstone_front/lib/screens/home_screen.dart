import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Center(
            child: Text("캡스톤"),
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
}
