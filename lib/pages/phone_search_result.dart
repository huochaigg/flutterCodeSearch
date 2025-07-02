import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 状态管理
import 'package:provider/provider.dart';
import '../state/user_state.dart';

// 自定义组件
import '../components/loading_dialog.dart';       // loading组件
import '../components/toast.dart';                // 提示组件

/// 
/// 电话号码查询结果页面
/// 
/// 查询接口使用百度智能云api：
/// https://apis.baidu.com/store/detail/51d4c4fa-002e-4592-853c-2aaedf39d457
///*/ 
class PhoneSearchResult extends StatefulWidget {
  const PhoneSearchResult({Key? key}) : super(key: key);

  @override
  _PhoneSearchResultState createState() => _PhoneSearchResultState();
}

class _PhoneSearchResultState extends State<PhoneSearchResult> {

  Map phoneOriginData = {};
  dynamic loading;
  // dynamic userStateProvider;

  // 渲染查询结果
  Widget _renderSearchResult () {
    if (phoneOriginData['code'] != 200) {
      String message = phoneOriginData['message'] ?? '';
      return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), 
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 16.0,
          )
        )
      );
    }
    String prov = phoneOriginData['data']['prov'];    // 省
    String city = phoneOriginData['data']['city'];    // 市
    String types = phoneOriginData['data']['types'];  // 号码类型：中国移动 中国联通...
    return ListTile(
      title: Text(city),
      subtitle: Text('$prov $city $types'),
      leading: Image.asset(
        'images/icon-phone.jpeg',
        width: 40.0,
        height: 40.0
      )
    );
  }
  
  // 请求 查询电话好吗归属地
  void _getPhoneOrigin () async {
    loading.show(text: '加载中...');

    // 从UserState中获取Appcode
    String phoneSearchCode = context.read<UserState>().phoneSearchCode;
    // 从路由中取得参数：phoneNumber
    String phoneNumber = (ModalRoute.of(context)?.settings.arguments as Map)['phoneNumber'];
    var url = Uri.parse('https://hcapi02.api.bdymkt.com/mobile?mobile=$phoneNumber');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'X-Bce-Signature': 'AppCode/$phoneSearchCode',
    });
    // 请求返回的数据需要转换下response.bodyBytes，
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['code'] != 200) {
      loading.hide();
      // 错误提示
      showWarnToast(data['message']);
    }
    setState(() {
      phoneOriginData = data;
    });

    loading.hide();
  }

  @override
  void initState() {
    // 调用: 这里是必须调用super
    super.initState();
    
    loading = LoadingDialog(context);

    Future.delayed(Duration.zero, () {
      _getPhoneOrigin();
    });
  }

  @override
  Widget build(BuildContext context) {
    String _phoneNumber = (ModalRoute.of(context)?.settings.arguments as Map)['phoneNumber'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('查询结果')
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // 展示输入的电话号码
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), 
                  child: Text(
                    _phoneNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                const SizedBox(
                  height: 10.0,
                ),
                
                // 查询结果
                _renderSearchResult(),
              ],
            ),
          )
        ],
      )
    );
  }
}