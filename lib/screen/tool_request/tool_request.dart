import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/screen/tool_request/request/request.dart';
import 'package:ez_xpert/screen/tool_request/request_card.dart';
import 'package:ez_xpert/screen/tool_request/tool_request_vm.dart';
import 'package:flutter/material.dart';

class ToolRequest extends StatefulWidget {
  const ToolRequest({Key? key}) : super(key: key);

  @override
  _ToolRequestState createState() => _ToolRequestState();
}

class _ToolRequestState extends State<ToolRequest>
    with BasePage<ToolRequestVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          actions: [
            const Icon(Icons.person),
            Center(child: Text("  ${provider.prefs.user?.name ?? "user"}  "))
          ],
          title: const Text("Tool Request"),
        ),
        floatingActionButton: MaterialButton(
          height: 50,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () async {
            var data = await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                contentPadding: EdgeInsets.zero,
                content: ToolRequestPopup(
                  tools: provider.tools,
                ),
              ),
            );
            if (data == true) {
              provider.getTools();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add_circle_rounded,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                "Tool Request",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: provider.requests.length,
            itemBuilder: (context, i) {
              return RequestCard(
                data: provider.requests[i],
              );
            }),
      ),
    );
  }

  @override
  ToolRequestVM create() => ToolRequestVM();

  @override
  void initialise(BuildContext context) {}
}
