import 'package:flutter/material.dart';

class DateChanger extends StatefulWidget {
  const DateChanger({super.key});

  @override
  _DateChangerState createState() => _DateChangerState();
}

class _DateChangerState extends State<DateChanger> {
  DateTime currentDate = DateTime.now();

  void _decreaseDate() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
    });
  }

  void _increaseDate() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              onPressed: _decreaseDate, // 날짜 감소 로직
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              '${currentDate.month.toString().padLeft(2, '0')}.${currentDate.day.toString().padLeft(2, '0')}(${_getWeekDayName(currentDate.weekday)})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: _increaseDate, // 날짜 증가 로직
            ),
          ),
        ),
      ],
    );
  }

  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        return '';
    }
  }
}
