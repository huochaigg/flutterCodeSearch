import 'package:flutter/material.dart';
import '../components/toast.dart';

/// 
/// 电话号码查询页面
///*/ 
class Phone extends StatefulWidget {
  const Phone({Key? key, String? title}) : super(key: key);
  
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {

  // 输入手机号码
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,              // 不能和decoration 同时用
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Column(
        children: [
          // 输入框
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '请输入电话号码',
              labelText: '电话'
            ),
            onChanged:(value){
              setState(() {  
                phoneNumber = value;
              });
            }
          ),
          const SizedBox(height: 20),

          // 用SizedBox包裹可以设置 按钮宽度占满整行
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              child: const Text("查询"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),   // 按钮字体颜色
              ),
              onPressed: () {
                if (phoneNumber == '') {
                  showWarnToast('手机号码不能为空');
                  return;
                }
                Navigator.pushNamed(context, '/phoneSearchResult', arguments: {
                  "phoneNumber": phoneNumber
                });
              },
            )
          )
        ],
      ),
    );
  }
}
