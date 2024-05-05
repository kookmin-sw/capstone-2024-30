import 'package:flutter/material.dart';

class WhiteBox extends StatefulWidget {
  Widget content;
  WhiteBox({
    super.key,
    required this.content,
  });

  @override
  State<WhiteBox> createState() => _WhiteBoxState();
}

class _WhiteBoxState extends State<WhiteBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2.0,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: widget.content,
      ),
    );
  }
}
