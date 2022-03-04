import 'package:dropdown_search/dropdown_search.dart';
import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/knowledge_base/knowledge_vm.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Knowledge extends StatefulWidget {
  const Knowledge({Key? key}) : super(key: key);

  @override
  _KnowledgeState createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> with BasePage<KnowledgeVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          actions: [
            const Icon(Icons.person),
            Center(child: Text("  ${provider.prefs.user?.name ?? "user"}  "))
          ],
          title: const Text("Knowledge Base"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: DropdownSearch<dynamic>(
                        dropdownSearchDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          label: const Text("Tag"),
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        mode: Mode.MENU,
                        items: const ["Demo ", "Tool", "KT", "Others"],
                        itemAsString: (val) {
                          if (val.runtimeType == String) {
                            return val;
                          }
                          return val.name;
                        },
                        showClearButton: false,
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          label: const Text("Key word"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        provider.getKnowledge();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.knowledge.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: MaterialButton(
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(provider.knowledge[i]['remark']),
                        ),
                      ),
                      onPressed: () async {
                        _launchURL(provider.knowledge[i]['youtube_link']);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final link = (url.toString().contains("http")) ? url : " http://$url";
    if (!await launch(link)) throw 'Could not launch $link';
  }

  @override
  KnowledgeVM create() => KnowledgeVM();

  @override
  void initialise(BuildContext context) {}
}
