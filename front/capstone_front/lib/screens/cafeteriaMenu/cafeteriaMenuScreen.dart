import 'package:capstone_front/screens/cafeteriaMenu/dateChanger.dart';
import 'package:capstone_front/screens/cafeteriaMenu/menuCard.dart';
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          '학식정보',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const DateChanger(),
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
                Expanded(
                  child: Container(
                      color: const Color(0xFFF8F8F8),
                      child: const Column(
                        children: [
                          MenuCard(
                            section: "인터쉐프 중식",
                            menu: "고깃집 볶음밥",
                            price: "5,000",
                          ),
                        ],
                      )),
                ),
                const Center(
                  child: Text("학생식당"),
                ),
                const Center(
                  child: Text("교직원식당"),
                ),
                const Center(
                  child: Text("청향 한식당"),
                ),
                const Center(
                  child: Text("청향 양식당"),
                ),
                const Center(
                  child: Text("생활관식당 일반식"),
                ),
                const Center(
                  child: Text("생활관식당 정기식"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
