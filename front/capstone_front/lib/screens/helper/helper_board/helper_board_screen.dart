import 'package:capstone_front/screens/helper/helper_board/helper_writing_card.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/screens/helper/helper_write_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class HelperBoardScreen extends StatefulWidget {
  const HelperBoardScreen({super.key});

  @override
  State<HelperBoardScreen> createState() => _HelperBoardState();
}

class _HelperBoardState extends State<HelperBoardScreen> {
  final List<String> _helperList = [
    tr('helper.total'),
    tr('helper.need_helper'),
    tr('helper.need_helpee'),
  ];
  int _selectedHelperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                selectWritingType(context),
                Container(
                  color: Colors.white,
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: HelperWritingCard(
                          index: index,
                        ),
                      );
                    },
                    itemCount: helperWriting.length,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              iconSize: 50,
              onPressed: () async {
                var articleObj = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelperWriteScreen(),
                  ),
                );
                // TODO
              },
              style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20,
          //   right: 0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(
          //         color: Theme.of(context).colorScheme.primary,
          //         width: 3,
          //       ),
          //     ),
          //     child: IconButton(
          //       iconSize: 50,
          //       onPressed: () {},
          //       style: IconButton.styleFrom(
          //         backgroundColor: Colors.white,
          //       ),
          //       icon: Icon(
          //         Icons.add,
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Row selectWritingType(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width - 40,
          height: 40,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemCount: _helperList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedHelperIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedHelperIndex == index
                          ? const Color(0xb4000000)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: _selectedHelperIndex == index
                          ? Border.all(
                              color: const Color(0x00000000),
                              width: 1.5,
                            )
                          : Border.all(
                              color: const Color(0xffE4E7EB), width: 1.5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _helperList[index],
                        style: _selectedHelperIndex == index
                            ? const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              )
                            : const TextStyle(
                                color: Color(0xFF464D57),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
