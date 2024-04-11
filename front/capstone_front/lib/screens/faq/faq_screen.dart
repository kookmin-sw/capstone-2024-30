import 'package:capstone_front/screens/faq/test_faq_data.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  String selectedItem = 'major';
  String selectedItemToShow = '전공';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: TextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: "검색어를 입력하세요",
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: Color(0XFFd7d7d7),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.2,
                    color: const Color(0xFF8266DF),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: <Widget>[
                                ...faqKinds.map(
                                  (item) => ListTile(
                                    onTap: () {
                                      setState(() {
                                        selectedItem = faqCategoryMapper[item]!;
                                        selectedItemToShow = item;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    title: Center(
                                      child: Text(
                                        item,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedItemToShow,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: faqs[selectedItem]!.length,
              itemBuilder: (context, index) {
                return Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      faqs[selectedItem]![index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(
                          faqs[selectedItem]![index]['content'],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  color: Color(0xFFc8c8c8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
