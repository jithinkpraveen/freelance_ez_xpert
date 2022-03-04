import 'package:ez_xpert/screen/call_schedule/call_schedule.dart';
import 'package:ez_xpert/screen/knowledge_base/knowledge.dart';
import 'package:ez_xpert/screen/notice/notice.dart';
import 'package:ez_xpert/screen/time_sheet/time_sheet.dart';
import 'package:ez_xpert/screen/tool_request/tool_request.dart';
import 'package:ez_xpert/utils/locator.dart';
import 'package:ez_xpert/utils/share_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final Function logOut;
  const DrawerWidget({Key? key, required this.logOut}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(locator<SharedPrefs>().user!.profilePic.toString() + "1234");
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    locator<SharedPrefs>().user?.photo ??
                        "https://www.shareicon.net/data/512x512/2016/05/24/770137_man_512x512.png?123",
                  ),
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  locator<SharedPrefs>().user?.name ?? "User",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timeline_sharp),
            title: const Text('Timesheet'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TimeSheet()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Notice'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Notice()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Knowledg Base'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Knowledge()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('On Call Schedule'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CallSchedule()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Tool Request'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ToolRequest()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'No'),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => logOut(),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
