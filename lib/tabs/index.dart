import 'package:flutter/material.dart';
import 'phone.dart';
import 'user.dart';

class Tabbar extends StatefulWidget {
  Tabbar({Key? key, required String routerName, Object? arguments, required String title}) : super(key: key);

  static const Phone _phone = Phone();
  static const User _user = User();

  // tabs 列表
  final Map<int, Map> pages = { 
    0: _createPage(_phone, routeName: '/', pageName: '电话号码查询归属地'),
    1: _createPage(_user, routeName: '/menu', pageName: 'flutter'),
  };

  static Map _createPage(Widget page, { required String routeName, String? pageName }) {
    return {
      "widget": page,
      "pageName": pageName,
      "routeName": routeName
    };
  }

  // 通过 routeName 获取对应页面的索引
  getPageIndex(routeName) {
    switch(routeName) {
      case '/phone': 
        return 0;
      case '/user': 
        return 1;
      default: 
        return 0;
    }
  }

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {

  static int currentIndex = 0;

  @override
  void initState() { 
    super.initState();
    
    Future.delayed(Duration.zero, () {
      String? routeName = ModalRoute.of(context)?.settings.name;
      setState(() {
        currentIndex = widget.getPageIndex(routeName);
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? page = widget.pages[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(page!['pageName'] ?? 'page'),
        backgroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      body: Container(
        color: hex('#fff'),
        child: page['widget']
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.search), label: widget.pages[0]!['pageName']),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: widget.pages[1]!['pageName']),
          ],
          unselectedFontSize: 10,           // 未选中字体大小
          selectedFontSize: 10,             // 选中字体大小
          selectedItemColor: Colors.yellow, // 选中字体颜色
          currentIndex: currentIndex,       // 选中的tab
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        )
      )
    );
  }

  hex(String s) {}
}