import 'package:flutter/material.dart';
import 'package:cms/Models/user_model.dart';
import 'auth_wrapper.dart';
import 'package:cms/Pages/main_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userStream = Provider.of<UserModel>(context);
    print(userStream);

    if (userStream == null) {
      return AuthWrapper();
    } else {
      return HomeMain();
    }
  }
}
