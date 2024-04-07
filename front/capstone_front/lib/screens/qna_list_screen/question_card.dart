import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String title, content, name, country, tag;

  const QuestionCard({
    super.key,
    required this.title,
    required this.content,
    required this.name,
    required this.country,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xfff3f1fe),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 6,
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Color(0xFF9375e6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Q. ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff7b7b89),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  country,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFa1a1ad),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
