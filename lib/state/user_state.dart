// 使用了flutter的provider做状态管理
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {

  String _phoneSearchCode = 'de2e83306e804da58e1a9613c191aa68';  // 百度号码查询归属地 Appcode 

  // 定义一个get方法，在外界获取私有状态值
  String get phoneSearchCode => _phoneSearchCode;
  
  // 修改 _phoneSearchCode（更新状态）
  incCount(String value){
    _phoneSearchCode = value;
    //表示更新状态.它会重新触发所有监听了该Provider的类的build方法
    //当notifyListeners方法执行的时候，购物车页面与我的页面的build方法都会被重新触发
    notifyListeners();
  }
}