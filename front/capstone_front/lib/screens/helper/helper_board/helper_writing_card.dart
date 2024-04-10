import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelperWritingCard extends StatefulWidget {
  final int index;
  const HelperWritingCard({
    super.key,
    required this.index,
  });

  @override
  State<HelperWritingCard> createState() => _HelperWritingCardState();
}

class _HelperWritingCardState extends State<HelperWritingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xffd2d7dd),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.push('/helper/writing', extra: widget.index);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  helperWriting[widget.index][0],
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${helperWriting[widget.index][1]} | ${helperWriting[widget.index][2]}',
                  style: const TextStyle(
                    fontFamily: 'pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff868e96),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
