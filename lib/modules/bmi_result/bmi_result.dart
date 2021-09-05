import 'package:flutter/material.dart';
class BmiResultScreen extends StatelessWidget {
  final int result;
  final bool isMale;
  final int age;
  BmiResultScreen({
    @required this.result,
    @required this.isMale,
    @required this.age,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender : ${isMale ? "Male":"Female"}",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
            Text("Result : ${result.round()}",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
            Text("Age : $age",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
          ],
        ),
      ),
    );
  }
}
