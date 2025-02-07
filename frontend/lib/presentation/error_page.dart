import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(
              height: 50,
            ),
            Text("Something went wrong :("),
            ElevatedButton(onPressed: (){
              context.go(Routes.home);
            }
                , child: Text("Home"))
          ],
        ),
      ),
    );

    throw UnimplementedError();
  }
}
