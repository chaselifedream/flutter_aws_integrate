// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aws_integrate/models/user.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            _UserData()
          ],
        ),
      ),
    );
  }
}


class _UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.display4.copyWith(fontSize: 10);
    var user = Provider.of<UserModel>(context);

    return Container(

      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            */
            //Text('Total \$${cart.totalPrice}', style: hugeStyle),
            Flexible(child: Text('Username: ${user.username}', style: hugeStyle)),
            Flexible(child: Text('Attributes: ${user.userAttributes}', style: hugeStyle)),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                user.changeUsername();
              },
              color: Colors.white,
              child: Text('Chnage username'),
            ),
          ],
        ),
      ),
    );
  }
}
