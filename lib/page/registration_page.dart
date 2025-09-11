import 'package:bili_app/widget/login_input.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 屏幕长度不够可滚动到最下面，自适应键盘弹起，防止遮挡
        child: ListView(
          children: [
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (text) {
                print(text);
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              lineStretch: true,
              onChanged: (text) {
                print(text);
              },
            )
          ],
        ),
      ),
    );
  }
}
