import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  Function(String) searchCallback;

  SearchScreen({
    super.key,
    required this.searchCallback,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 47,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Transform.translate(
                    offset: const Offset(0, 2),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          if (MediaQuery.of(context).viewInsets.bottom > 0) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          } else {
                            context.pop();
                          }
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: (text) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        if (_controller.text.length >= 2) {
                          context.pop();
                          widget.searchCallback(_controller.text);
                        } else {
                          Fluttertoast.showToast(
                            msg: tr("searchScreen.more_than_two"),
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 20,
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: tr("searchScreen.enter_word"),
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6F767F),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
