import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelperWritingScreen extends StatefulWidget {
  const HelperWritingScreen({super.key});

  @override
  State<HelperWritingScreen> createState() => _HelperWritingScreenState();
}

class _HelperWritingScreenState extends State<HelperWritingScreen> {
  @override
  Widget build(BuildContext context) {
    final int index = GoRouterState.of(context).extra! as int;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('helper.helper'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                  'assets/images/carrot_profile.png'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                helperWriting[index][1],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                '소프트웨어학부 | 19학번',
                                style: TextStyle(
                                    fontFamily: 'pretendard',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff868e96)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Color(0xffe9ecef)),
                    const SizedBox(height: 20),
                    Text(
                      helperWriting[index][0],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ\n친구가 없어요 ㅠㅠ"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BasicButton(
                text: tr('helper.start_chat'),
                onPressed: () {
                  context.push("/chatroom");
                })
          ],
        ),
      ),
    );
  }
}
