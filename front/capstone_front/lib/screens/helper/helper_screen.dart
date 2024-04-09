import 'package:capstone_front/screens/helper/helper_writing_card.dart';
import 'package:capstone_front/screens/helper/helper_writing_json.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  final List<String> _helperList = [
    tr('helper.total'),
    tr('helper.need_helper'),
    tr('helper.need_helpee'),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('helper.helper'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 5,
                  color: Colors.white,
                ),
                selectWritingType(context),
                Container(
                  color: Colors.white,
                  height: 10,
                ),
                // Container(
                //   height: 1,
                //   decoration: const BoxDecoration(
                //     color: Color(0xffd2d7dd),
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return HelperWritingCard(
                        index: index,
                      );
                    },
                    itemCount: helperWriting.length,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 0,
              child: IconButton(
                iconSize: 50,
                onPressed: () {
                  context.push('/helper/write');
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
                padding: EdgeInsets.only(
                    right: index == _helperList.length - 1
                        ? 0
                        : 15), // 마지막 아이템에는 패딩을 적용하지 않음.
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? const Color(0xb4000000)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: _selectedIndex == index
                            ? Border.all(color: const Color(0x00000000))
                            : Border.all(
                                color: const Color(0xffE4E7EB),
                              )),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _helperList[index],
                        style: _selectedIndex == index
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
