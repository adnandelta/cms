import 'package:flutter/material.dart';
import 'package:cms/Pages/register_page.dart';
import 'package:cms/Pages/sign_in.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool showSignIN = true;

  void toggleForms() {
    setState(() {
      showSignIN = !showSignIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIN) {
      return AuthWid(toggler: toggleForms);
    } else {
      return RegisterWidget(toggler: toggleForms);
    }
  }
}
