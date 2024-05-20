import 'package:capstone_front/main.dart';
import 'package:capstone_front/models/cafeteria_menu_model.dart';
import 'package:capstone_front/screens/cafeteriaMenu/menuCard.dart';
import 'package:capstone_front/screens/main_screen.dart';
import 'package:capstone_front/services/cafeteria_menu_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CafeteriaMenuScreen extends StatefulWidget {
  const CafeteriaMenuScreen({super.key});

  @override
  State<CafeteriaMenuScreen> createState() => _CafeteriaMenuScreenState();
}

class _CafeteriaMenuScreenState extends State<CafeteriaMenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 7, vsync: this);

  late DateTime currentDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('mainScreen.cafeteria'),
          style: const TextStyle(),
        ),
      ),
      body: Column(
        children: [
          Row(
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
                    '${currentDate.month.toString().padLeft(2, '0')}.${currentDate.day.toString().padLeft(2, '0')} (${_getWeekDayName(currentDate.weekday)})',
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
          ),
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: tabController,
            tabs: const <Widget>[
              Tab(
                text: "한울식당",
              ),
              Tab(
                text: "학생식당",
              ),
              Tab(
                text: "교직원식당",
              ),
              Tab(
                text: "청향 한식당",
              ),
              Tab(
                text: "청향 양식당",
              ),
              Tab(
                text: "생활관식당 일반식",
              ),
              Tab(
                text: "생활관식당 정기식",
              ),
            ],
          ),
          FutureBuilder(
              future: getCafeteriaMenu(currentDate.toString().substring(0, 10)),
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    children: [
                      SizedBox(height: 30),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(tr('cafeteria.error_message')));
                } else {
                  return Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        for (int i = 0; i <= 6; i++)
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                if (snapshot.data.cafeteriaMenus[i].isEmpty)
                                  Center(child: Text(tr('cafeteria.no_data'))),
                                for (var data
                                    in snapshot.data.cafeteriaMenus[i])
                                  MenuCard(data: data),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  void _decreaseDate() {
    setState(() {
      currentDate = currentDate.subtract(const Duration(days: 1));
      print(currentDate);
    });
  }

  void _increaseDate() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
      print(currentDate);
    });
  }

  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return tr('weekday.mon');
      case 2:
        return tr('weekday.tue');
      case 3:
        return tr('weekday.wed');
      case 4:
        return tr('weekday.thu');
      case 5:
        return tr('weekday.fri');
      case 6:
        return tr('weekday.sat');
      case 7:
        return tr('weekday.sun');
      default:
        return '';
    }
  }
}
