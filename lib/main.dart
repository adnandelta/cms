import 'package:flutter/material.dart';

import 'Models/user_model.dart';

import 'Wrappers/main_wrapper.dart';
import 'Wrappers/auth_wrapper.dart';

import 'services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
