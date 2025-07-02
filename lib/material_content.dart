import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './state/user_state.dart';
import 'routes.dart';

class MaterialContent extends StatefulWidget {
  const MaterialContent({Key? key, String? title}) : super(key: key);

  @override
  _MaterialContentState createState() => _MaterialContentState();
}

class _MaterialContentState extends State<MaterialContent> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //在MaterialApp外层嵌套一个MultiProvider
      providers: [
        /** 在这里面配置全局监听的类*/
        ChangeNotifierProvider<UserState>(create: (_) => UserState())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: routes,
        initialRoute: "/", 
        debugShowCheckedModeBanner: false,    // 隐藏debug icon
        theme: ThemeData(
          // 设置主题色
          primaryColor: Colors.amber,         
          primarySwatch: Colors.amber,
        ),
        onGenerateRoute: onGenerateRoute
      )
    );
  }
}