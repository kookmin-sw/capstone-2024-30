import 'package:capstone_front/main.dart';
import 'package:capstone_front/screens/faq/test_faq_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FaqScreen extends StatefulWidget {
  final Function(String) performSearch;
  final TextEditingController searchController;

  const FaqScreen(
      {super.key, required this.performSearch, required this.searchController});

  @override
  State<FaqScreen> createState() => FaqScreenState();
}

FlutterSecureStorage storage = const FlutterSecureStorage();

class FaqScreenState extends State<FaqScreen> {
  String selectedItem = 'major';
  String selectedItemToShow = language == 'KO'
      ? '전공'
      : language == "EN-US"
          ? "major"
          : "专业";

  List<Map<String, dynamic>> filteredFaqs = [];
  // String? language;

  Future<void> initialize() async {
    // language = await storage.read(key: "language");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    initialize();
    filteredFaqs = faqs[selectedItem]!;
    widget.searchController.addListener(() {
      widget.performSearch(widget.searchController.text);
    });
  }

  String translateTagOtherToEn(String ohterTag, String nowLanguage) {
    switch (nowLanguage) {
      case 'KO':
        return faqCategoryMapperKoToEn[ohterTag] ?? ohterTag;
      case 'ZH':
        return faqCategoryMapperZhToEn[ohterTag] ?? ohterTag;
      default:
        return ohterTag;
    }
  }

  void filterFaqs(String query) {
    final List<Map<String, dynamic>> allFaqs = faqs[selectedItem]!;
    if (query.isEmpty) {
      filteredFaqs = allFaqs;
    } else {
      filteredFaqs = allFaqs.where((faq) {
        final title = faq['title'].toLowerCase();
        final content = faq['content'].toLowerCase();
        final searchQuery = query.toLowerCase();
        return title.contains(searchQuery) || content.contains(searchQuery);
      }).toList();
    }
    setState(() {});
  }

  void changeCategory(String category) {
    selectedItemToShow = category;
    category = translateTagOtherToEn(category, language);
    print(category);
    setState(() {
      selectedItem = category;
      filteredFaqs = faqs[selectedItem]!;
      widget.performSearch(widget.searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 40,
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
                                      changeCategory(item);
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
              itemCount: filteredFaqs.length,
              itemBuilder: (context, index) {
                return Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      filteredFaqs[index]['title'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(
                          filteredFaqs[index]['content'],
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
          ),
        ],
      ),
    );
  }
}
