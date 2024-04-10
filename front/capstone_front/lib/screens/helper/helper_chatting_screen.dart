import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelperChattingScreen extends StatefulWidget {
  const HelperChattingScreen({super.key});

  @override
  State<HelperChattingScreen> createState() => _HelperChattingScreenState();
}

class _HelperChattingScreenState extends State<HelperChattingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('helper.helper'),
        ),
      ),
    );
  }
}
