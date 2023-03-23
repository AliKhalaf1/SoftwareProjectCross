import 'package:flutter/material.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';

void loggingIn(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return const SignUpOrLogIn();
  }));
}
