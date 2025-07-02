import 'package:flutter/material.dart';
import 'tabs/index.dart';
import '/pages/phone_search_result.dart';

/// 路由
/// tab页面需要在Tabbar组件中设置
/// 
///*/ 
final Map<String, Widget Function(BuildContext)> routes = {
  // tab 页
  "/": (BuildContext context, {arguments}) => Tabbar(title: '电话号码查询归属地', routerName: '',), //注册首页路由
  "/user": (BuildContext context, {arguments}) => Tabbar(title: '', routerName: '',),

  // 其他非tab页面
  "/phoneSearchResult": (context, {arguments}) => const PhoneSearchResult(),
};

// 固定写法
Route? onGenerateRoute (RouteSettings settings) {      
  //String? 表示name为可空类型
  final String? name = settings.name; 
  //Function? 表示pageContentBuilder为可空类型
  final Function? pageContentBuilder = routes[name];      
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
          pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) =>
          pageContentBuilder(context));
      return route;
    }
  }
  return null;
}