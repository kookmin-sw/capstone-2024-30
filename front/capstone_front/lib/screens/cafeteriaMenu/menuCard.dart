import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final List<String> data;

  const MenuCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    String section = data[0];
    String menu = data[1];
    String price = data[2];

    // menu
    menu = menu.replaceAll('\r\n', ' ');
    // ※가 2번 나오면 줄바꿈
    int tmp1 = 0;
    // []가 2번 이상 나오면 줄바꿈
    int tmp2 = 0;
    for (int i = 0; i < menu.length; i++) {
      if (menu[i] == '※') {
        tmp1 += 1;
        if (tmp1 == 1) {
          menu = '${menu.substring(0, i + 1)} ${menu.substring(i + 1)}';
        }
      } else if (menu[i] == '[') {
        tmp2 += 1;
        if (tmp2 >= 2) {
          menu = '${menu.substring(0, i)}\n${menu.substring(i)}';
          i += 2;
        }
      }
      if (tmp1 == 2) {
        tmp1 = 0;
        menu = '${menu.substring(0, i + 1)}\n${menu.substring(i + 2)}';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                menu,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              if (price != "0")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\u20A9$price',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    // Add any additional widgets here
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
