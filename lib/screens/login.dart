// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:aws_integrate/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> doLoad() async {
    UserStatus userStatus;

    try {
      userStatus = await FlutterAwsAmplifyCognito.initialize();
    }
    catch (e, trace) {
      print(e);
      print(trace);

      return;
    }

    // The user is already signed in
    if (userStatus == UserStatus.SIGNED_IN) {
      var user = Provider.of<UserModel>(context, listen: false);

      String username = await FlutterAwsAmplifyCognito.getUsername();
      Map<String, String> userAttributes = await FlutterAwsAmplifyCognito.getUserAttributes();

      user.init(username, userAttributes);

      //Navigator.pushReplacementNamed(context, '/user');
      Navigator.pushNamed(context, '/user');
    }
  }

  Future<void> signIn() async {
    debugPrint('login: ${usernameController.text}, ${passwordController.text}');
    try {
      SignInResult result = await FlutterAwsAmplifyCognito.signIn(usernameController.text, passwordController.text);

      bool isSignedIn = await FlutterAwsAmplifyCognito.isSignedIn();
      print ('Is user signed in?: $isSignedIn');

      String username = await FlutterAwsAmplifyCognito.getUsername();
      debugPrint('username is $username');

      String identityId = await FlutterAwsAmplifyCognito.getIdentityId();
      debugPrint('Identity ID is $identityId');

      var userAttributes = await FlutterAwsAmplifyCognito.getUserAttributes();
      debugPrint('user attributes are $userAttributes');

      String accessToken = await FlutterAwsAmplifyCognito.getAccessToken();
      debugPrint('Access Token: $accessToken');

      /* Need to enable at Cognito first
      Device deviceDetails = await FlutterAwsAmplifyCognito.getDeviceDetails();
      debugPrint('createDate: ${deviceDetails.createDate}');
      debugPrint('deviceKey: ${deviceDetails.deviceKey}');
      debugPrint('lastAuthenticatedDate: ${deviceDetails.lastAuthenticatedDate}');
      debugPrint('lastModifiedDate: ${deviceDetails.lastModifiedDate}'); 
      debugPrint('attributes: ${deviceDetails.attributes}');
      */

      Navigator.pushNamed(context, '/user');      
    }
    catch (e, trace) {
      print(e);
      print(trace);
    }

  }

  @override
  void initState() {
    super.initState();

    doLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<UserModel>(
                builder: (context, user, child) => 
                  Text(
                    'Welcome: ${user.username}',
                    style: Theme.of(context).textTheme.display4,
                  ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                controller: usernameController
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {
                  signIn();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
