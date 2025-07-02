import 'package:flutter/material.dart';

/// loading 框 
/// params: 
///   BuildContext context 上下文对象
/// 
/// var loading = LoadingDialog(context);
/// loading.show();
/// loading.show(text: '自定义提示...');
/// loading.hide();
///*/ 
class LoadingDialog {
  String? text;
  BuildContext context;
  
  LoadingDialog(this.context);

  var _isShow = false;

  void show({String? text}) {
    String _text = text ?? '正在加载，请稍后...';
    if (_isShow) return;
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const CircularProgressIndicator(),

              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text(_text),
              )
            ],
          ),
        );
      },
    );
    _isShow = true;
  }

  void hide() {
    if (!_isShow) return;
    Navigator.of(context).pop();
    _isShow = false;
  }
}