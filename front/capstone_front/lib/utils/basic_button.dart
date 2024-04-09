import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed; // 콜백 함수를 위한 매개변수 추가

  const BasicButton({
    super.key,
    required this.text,
    required this.onPressed, // 생성자를 통해 콜백 함수를 필수적으로 받음
  });

  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
