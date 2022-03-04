import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/notice/notice_vm.dart';
import 'package:flutter/material.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> with BasePage<NoticeVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          actions: [
            const Icon(Icons.person),
            Center(child: Text("  ${provider.prefs.user?.name ?? "user"}  "))
          ],
          title: const Text("Notice"),
        ),
        body: ListView.builder(
          itemCount: provider.notice.length,
          itemBuilder: (context, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    boxShadow: [
                      BoxShadow(color: Colors.grey[400]!, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${provider.notice[i]['title']}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 5)
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${provider.notice[i]['content']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Warning",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  NoticeVM create() => NoticeVM();

  @override
  void initialise(BuildContext context) {}
}
