import 'package:bili_app/util/color.dart';
import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginBtn(this.title, {super.key, required this.enable, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }
}
