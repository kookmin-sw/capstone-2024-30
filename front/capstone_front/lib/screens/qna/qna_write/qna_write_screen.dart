import 'dart:io';

import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/services/qna_service.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class QnaWriteScreen extends StatefulWidget {
  const QnaWriteScreen({
    super.key,
    required this.qnas,
  });

  final List<QnaPostModel> qnas;

  @override
  State<QnaWriteScreen> createState() => _HelperWriteScreenState();
}

class _HelperWriteScreenState extends State<QnaWriteScreen> {
  final List<String> _helperWriteList = [
    tr('qna.category_1'),
    tr('qna.category_2'),
    tr('qna.category_3'),
    tr('qna.category_4'),
  ];
  int _selectedIndex = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final int _minLines = 1;
  final int _maxLines = 3;

  final picker = ImagePicker();
  XFile? image;
  List<XFile> multiImages = [];
  List<XFile> images = [];
  final int _maxPhotos = 4;
  int _currentPhotos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tr('helper.write'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('helper.type'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      selectWriteType(context),
                      const SizedBox(height: 20),
                      Text(
                        tr('helper.title'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      HelperWriteTextfield(
                        minLines: 1,
                        maxLines: 1,
                        isMultiline: false,
                        titleController: _titleController,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tr('helper.content'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      HelperWriteTextfield(
                        minLines: 10,
                        maxLines: 10,
                        isMultiline: true,
                        titleController: _contentController,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tr('사진'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          children: [
                            IconButton(
                              onPressed: () async {
                                if (_currentPhotos >= _maxPhotos) {
                                  makeToast("$_maxPhotos의 사진만 가능합니다");
                                } else {
                                  if (_maxPhotos - _currentPhotos < 2) {
                                    var image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (image != null) {
                                      multiImages = [image];
                                      setState(() {
                                        images.addAll(multiImages);
                                        _currentPhotos += multiImages.length;
                                      });
                                    }
                                  } else {
                                    multiImages = await picker.pickMultiImage(
                                      limit: _maxPhotos - _currentPhotos,
                                    );
                                    setState(() {
                                      images.addAll(multiImages);
                                      _currentPhotos += multiImages.length;
                                    });
                                  }
                                }
                              },
                              icon: const Icon(Icons.photo_library_rounded),
                              iconSize: 50,
                            ),
                            ...images.map(
                              (item) => Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(item.path),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        //삭제 버튼
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.close,
                                              color: Colors.white, size: 15),
                                          onPressed: () {
                                            setState(
                                              () {
                                                images.remove(item);
                                                _currentPhotos -= 1;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BasicButton(
              text: tr('helper.write_complete'),
              onPressed: () async {
                if (_titleController.text != "" &&
                    _contentController.text != "") {
                  var articleInfo = {
                    "title": _titleController.text,
                    "content": _contentController.text,
                    "author": "messi",
                    "category": "temp",
                    "country": "korea",
                  };

                  // TODO 글쓴 정보들로 글쓰기 post 보내기
                  // id를 리턴받아서 qnas list에 넣기
                  // Map<String, dynamic> res =
                  //     await QnaService.createQnaPost(articleInfo, images);
                  var qnaPost = {
                    "title": _titleController.text,
                    "author": "author",
                    "context": _contentController.text,
                    "tag": "tagggg",
                    "country": "qwe",
                  };
                  var res = await QnaService.createQnaPost(qnaPost, images);
                  print(res);
                  print('@@@@@');

                  widget.qnas.insert(
                      0,
                      QnaPostModel(
                        id: res['questionResponse']['id'],
                        title: res['questionResponse']['title'],
                        author: res['questionResponse']['author'],
                        content: res['questionResponse']['context'],
                        category: res['questionResponse']['tag'],
                        country: res['questionResponse']['country'],
                        answerCount: 0,
                        createdDate: res['questionResponse']['createdDate'],
                      ));
                  Navigator.pop(context);
                } else {
                  makeToast("내용을 다 채워주세요");
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Row selectWriteType(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width - 40,
          height: 40,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemCount: _helperWriteList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index == _helperWriteList.length - 1
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
                        _helperWriteList[index],
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

class HelperWriteTextfield extends StatelessWidget {
  const HelperWriteTextfield({
    super.key,
    required int minLines,
    required int maxLines,
    required bool isMultiline,
    required TextEditingController titleController,
  })  : _minLines = minLines,
        _maxLines = maxLines,
        _isMultiline = isMultiline,
        _titleController = titleController;

  final int _minLines;
  final int _maxLines;
  final bool _isMultiline;
  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: _isMultiline ? TextInputType.multiline : TextInputType.text,
      minLines: _minLines,
      maxLines: _maxLines,
      controller: _titleController,
      textInputAction:
          _isMultiline ? TextInputAction.newline : TextInputAction.next,
      onSubmitted: (value) {
        _isMultiline ? null : FocusScope.of(context).nextFocus();
      },
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE4E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: EdgeInsets.all(10)),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
