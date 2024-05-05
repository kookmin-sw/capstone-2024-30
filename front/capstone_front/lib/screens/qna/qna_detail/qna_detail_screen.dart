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

  bool isLoading = true;
  late QnaPostDetailModel qnaPostDetailModel;

  // TODO 좋아요 테러 방지를 위해 이 스크린을 떠날 때, 최초의 데이터와 비교하여 다른점만 서버에 post
  List<bool> likeList = List.filled(comments.length, false);
  List<int> likeCount = List.filled(comments.length, 0);

  Future<void> loadQnaPostDetail(int id) async {
    qnaPostDetailModel = await QnaService.getQnaPostDetailById(id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    print(1);
    loadQnaPostDetail(widget.postModel.id);
    print(2);
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
      body: Container(
        color: const Color(0xFFF4F4F4),
        child: SingleChildScrollView(
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
                            !isLoading && qnaPostDetailModel.imgUrl.isNotEmpty
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
                                                BorderRadius.circular(5),
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
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 20,
                                      ),
                                      itemCount:
                                          qnaPostDetailModel.imgUrl.length,
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
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comments[index]['author'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF444444),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    comments[index]['writeTime'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF848484),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                comments[index]['content'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
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
                                likeCount[index].toString(),
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
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
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
                              // onTap: () {
                              //   if (_scrollController.position ==
                              //       _scrollController.position.maxScrollExtent) {
                              //     _scrollController.jumpTo(
                              //         _scrollController.position.maxScrollExtent);
                              //   }
                              // },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
