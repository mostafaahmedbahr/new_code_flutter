 import 'package:cousre_code/models/model_user.dart';
import 'package:flutter/material.dart';
class UserScreen extends StatelessWidget {
  List<UserModel> users=[
    UserModel(
      id: 1,
      name: "mostafa",
      phone: "01110690299",
    ),
    UserModel(
      id:2,
      name: "bahr",
      phone: "01250690299",
    ),
    UserModel(
      id: 3,
      name: "ahmed",
      phone: "01550190299",
    ),
    UserModel(
      id: 1,
      name: "mostafa",
      phone: "01110690299",
    ),
    UserModel(
      id:2,
      name: "bahr",
      phone: "01250690299",
    ),
    UserModel(
      id: 3,
      name: "ahmed",
      phone: "01550190299",
    ),
    UserModel(
      id: 1,
      name: "mostafa",
      phone: "01110690299",
    ),
    UserModel(
      id:2,
      name: "bahr",
      phone: "01250690299",
    ),
    UserModel(
      id: 3,
      name: "ahmed",
      phone: "01550190299",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body:ListView.separated(
        itemBuilder:(context,index)=>buildUserItem(users[index]) ,
        separatorBuilder:(context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount:users.length,
      ),
    );
  }
  Widget buildUserItem(UserModel user)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          child: Text("${user.id}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${user.name}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
            Text(
                "${user.phone}"),
          ],
        ),
      ],
    ),
  );
}
