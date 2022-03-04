import 'package:ez_xpert/base/base_page.dart';
import 'package:ez_xpert/components/drawer/drwer.dart';
import 'package:ez_xpert/screen/home_main/home_page_vm.dart';
import 'package:ez_xpert/utils/locator.dart';
import 'package:ez_xpert/utils/share_prefs.dart';
import 'package:flutter/material.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({Key? key}) : super(key: key);

  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain>
    with BasePage<HomePageMainVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("EZ XPERT"),
          actions: [
            const Icon(Icons.person),
            Center(
              child: Text("  ${locator<SharedPrefs>().user?.name ?? "user"}  "),
            )
          ],
        ),
        drawer: DrawerWidget(logOut: provider.logOut),
        body: provider.buildHome(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.calendar_today_outlined,
              ),
              label: 'Check in/Out',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(Icons.flight),
              label: 'Vacation',
            )
          ],
          onTap: provider.changeIndex,
          currentIndex: provider.curentIndex,
        ),
      ),
    );
  }

  @override
  HomePageMainVM create() => HomePageMainVM();

  @override
  void initialise(BuildContext context) {}
}
