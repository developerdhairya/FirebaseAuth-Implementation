import 'package:flutter/material.dart';
import 'package:vartaa_messenger/pages/profile_page.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          toolbarTextStyle: TextStyle(fontSize: 16.1),
          title: Text("Vartaa Messenger"),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            labelColor: Colors.red,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.people_outline,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.chat_bubble_outline_outlined,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person_outline,
                  size: 25,
                ),
              )
            ],
          ),
        ),
        body: _tabBarPages(),
      ),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(children: [
     LoginPage(),
      LoginPage(),LoginPage()
    ]);
  }
}
