// Copyright 2019 Chase S. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aws_integrate/commoon/theme.dart';
import 'package:aws_integrate/models/user.dart';
import 'package:aws_integrate/screens/login.dart';
import 'package:aws_integrate/screens/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // Provider calls build() only one time
        Provider(create: (context) => UserModel())
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/user': (context) => User(),
        },
      ),
    );
  }
}
