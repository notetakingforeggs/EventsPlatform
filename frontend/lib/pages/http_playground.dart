import 'package:events_platform_frontend/services/api/api_service.dart';
import 'package:flutter/material.dart';

class HttpPlayground extends StatelessWidget {
  const HttpPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text("Network Actions", style: TextStyle(fontSize: 46),)),
            SizedBox(height: 60,),

            Padding(
              padding: const EdgeInsets.all(40.0),
              child: OutlinedButton(
                  onPressed: () {
                    print("outlined button");
                    ApiService().getData("api/v1/events");
                  },
                  child: Text("get data")),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                  onPressed: () {
                    print("elevatedButton");
                  },
                  child: Text("send Data", style: TextStyle(color: Colors.black),)),
            ),
          ],
        ));
  }
}
