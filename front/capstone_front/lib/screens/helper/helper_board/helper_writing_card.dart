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
    return InkWell(
      onTap: () {
        context.push('/helper/writing', extra: widget.index);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffd2d7dd),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
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
    );
  }
}
