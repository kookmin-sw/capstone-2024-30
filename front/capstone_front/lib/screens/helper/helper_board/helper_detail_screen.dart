import 'package:capstone_front/models/chat_init_model.dart';
import 'package:capstone_front/models/helper_model.dart';
import 'package:capstone_front/models/helper_article_model.dart';
import 'package:capstone_front/models/helper_article_preview_model.dart';
import 'package:capstone_front/screens/helper/helper_board/helper_writing_json.dart';
import 'package:capstone_front/services/helper_service.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class HelperDetailScreen extends StatefulWidget {
  final HelperArticlePreviewModel helperArticlePreviewModel;

  const HelperDetailScreen(
    this.helperArticlePreviewModel, {
    super.key,
  });

  @override
  State<HelperDetailScreen> createState() => _HelperDetailScreenState();
}

class _HelperDetailScreenState extends State<HelperDetailScreen> {
  late HelperArticleModel helperArticleModel;
  bool isLoading = true;
  bool isMyArticle = true;

  void loadDetail() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    helperArticleModel =
        await HelperService.getDetailById(widget.helperArticlePreviewModel.id);
    setState(() {
      isLoading = false;
    });
    final uuid = await storage.read(key: "uuid");
    if (uuid != helperArticleModel.uuid) {
      isMyArticle = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    loadDetail();
    super.initState();
  }

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
                                  widget.helperArticlePreviewModel.author,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.helperArticlePreviewModel.country,
                                  style: const TextStyle(
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
                        widget.helperArticlePreviewModel.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : Text(helperArticleModel.context),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (!isLoading)
                isMyArticle
                    ? BasicButton(
                        text: tr('helper.recruitment_complete'),
                        onPressed: () {
                          if (helperArticleModel.isDone) {
                            makeToast(
                                tr('helper.msg_already_recruitment_complete'));
                          } else {
                            makeToast(tr('helper.msg_recruitment_complete'));
                            HelperService.completeRecruitment(
                                widget.helperArticlePreviewModel.id);
                            context.pop();
                          }
                        },
                      )
                    : BasicButton(
                        text: tr('helper.start_chat'),
                        onPressed: () {
                          if (helperArticleModel.isDone) {
                            makeToast(
                                tr('helper.msg_already_recruitment_complete'));
                          } else {
                            var chatInitModel = ChatInitModel.fromJson({
                              'author': widget.helperArticlePreviewModel.author,
                              'uuid': helperArticleModel.uuid,
                            });
                            context.push("/chatroom", extra: chatInitModel);
                          }
                        },
                      )
            ],
          ),
        ));
  }
}

void makeToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    fontSize: 20,
  );
}
