import 'package:flutter/material.dart';
class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/1.jpg"),
            ),
            SizedBox(width: 15,),
            Text("Chats",
              style: TextStyle(
                color: Colors.black,
              ),),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Icon(Icons.camera_alt,
                  size: 16,
                  color: Colors.white,)),
            onPressed:(){},
          ),
          IconButton(
            icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Icon(Icons.edit,
                  size: 16,
                  color: Colors.white,)),
            onPressed:(){},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10,),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context,index)=>SizedBox(width: 15,),
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index)=>buildStoryItem(),
                  itemCount: 10,
                ),
              ),
              SizedBox(height: 20,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemBuilder:(context,index)=>buildChatItem(),
                itemCount: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }


//arrow function
  Widget buildChatItem()=>Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/1.jpg"),
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green,
          ),
        ],
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("mostafa bahr",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: Text("mostafa bahr ahmed ali bahr mostafa bahr ahmed ali bahr mostafa bahr ahmed ali bahr",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text("10:12 pm"),
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStoryItem()=>Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/1.jpg"),
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        SizedBox(height: 6,),
        Text("Mostafa Bahr ahmed bahr",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
