import 'package:capstone_front/main.dart';
import 'package:capstone_front/models/answer_model.dart';
import 'package:capstone_front/models/qna_post_model.dart';
import 'package:capstone_front/screens/qna/qna_detail/test_comment_data.dart';
import 'package:capstone_front/services/qna_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QnaDetailScreen extends StatefulWidget {
  final QnaPostModel postModel;

  const QnaDetailScreen({
    super.key,
    required this.postModel,
  });

  @override
  State<QnaDetailScreen> createState() => _QnaDetailScreenState();
}

class _QnaDetailScreenState extends State<QnaDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  bool isLoadingPost = true;
  bool isLoadingAnswer = true;
  late QnaPostDetailModel qnaPostDetailModel;
  List<AnswerModel> answerList = [];

  // TODO 좋아요 테러 방지를 위해 이 스크린을 떠날 때, 최초의 데이터와 비교하여 다른점만 서버에 post
  List<bool> likeList = [];
  List<int> likeCount = [];

  int cursor = 0;
  bool hasNext = true;
  int itemCount = 0;
  String sortBy = "date";

  Future<void> loadQnaPostDetail(int id) async {
    qnaPostDetailModel = await QnaService.getQnaPostDetailById(id);
    setState(() {
      isLoadingPost = false;
    });
  }

  Future<void> loadQnaAnswers() async {
    var answerReqObj = {
      "questionId": widget.postModel.id,
      "cursorId": cursor,
      "sortBy": sortBy,
    };
    var res = await QnaService.getAnswersByQuestionId(answerReqObj);
    hasNext = res.hasNext;
    if (res.hasNext) {
      setState(() {
        cursor = res.lastCursorId!;
      });
    }

    setState(() {
      answerList.addAll(res.answers);
      itemCount += res.answers.length;
      likeList = List.filled(100, false);
      likeCount = List.filled(100, 0);
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    loadQnaPostDetail(widget.postModel.id);
    loadQnaAnswers();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postModel.category),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                answerList = [];
                await loadQnaPostDetail(widget.postModel.id);
                await loadQnaAnswers();
              },
              child: Container(
                color: const Color(0xFFF4F4F4),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.postModel.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      widget.postModel.content,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF444444),
                                      ),
                                      softWrap: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    !isLoadingPost &&
                                            qnaPostDetailModel.imgUrl.isNotEmpty
                                        ? SizedBox(
                                            height: 200,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        qnaPostDetailModel
                                                            .imgUrl[index],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                width: 20,
                                              ),
                                              itemCount: qnaPostDetailModel
                                                  .imgUrl.length,
                                            ),
                                          )
                                        : const SizedBox(),
                                    // Image.network(
                                    //   "https://capstone-30-backend.s3.ap-northeast-2.amazonaws.com/ac031c03-aimage.png",
                                    //   width: 200,
                                    //   height: 200,
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: answerList.length,
                            itemBuilder: (context, index) {
                              if (index + 1 == itemCount && hasNext) {
                                loadQnaAnswers();
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              answerList[index].author,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xFF444444),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              answerList[index].createdDate,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xFF848484),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          answerList[index].content,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          likeList[index]
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                        ),
                                        color: const Color(0xFF848484),
                                        iconSize: 26,
                                        onPressed: () {
                                          setState(() {
                                            if (likeList[index]) {
                                              likeCount[index] -= 1;
                                            } else {
                                              likeCount[index] += 1;
                                            }
                                            likeList[index] = !likeList[index];
                                          });
                                        },
                                      ),
                                      Text(
                                        answerList[index].likeCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Divider(
                                color: Color(0xFFD8D8D8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: _textController,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration.collapsed(
                            hintText: "댓글을 입력하세요.",
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                          onTap: () {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          print('click');
                          if (_textController.text != "") {
                            var commentObj = {
                              "questionId": widget.postModel.id,
                              "author": userName,
                              "context": _textController.text,
                            };
                            _textController.clear();
                            var asnwerModel =
                                await QnaService.createAnswer(commentObj);
                            setState(() {
                              answerList.add(asnwerModel);
                            });

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (_scrollController.hasClients) {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                );
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
