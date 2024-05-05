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
