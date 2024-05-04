import 'package:capstone_front/main.dart';
import 'package:capstone_front/models/cafeteria_menu_model.dart';
import 'package:capstone_front/screens/cafeteriaMenu/dateChanger.dart';
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
          // const DateChanger(),
          Text(
            DateTime.now().toString().substring(0, 11),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
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
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                for (int i = 0; i <= 6; i++)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        if (menus.cafeteriaMenus[i].isEmpty)
                          Center(child: Text(tr('cafeteria.no_data'))),
                        for (var data in menus.cafeteriaMenus[i])
                          MenuCard(data: data),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
