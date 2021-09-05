import 'package:conditional_builder/conditional_builder.dart';
import 'package:cousre_code/modules/web_view_screen/web_view_screen.dart';
import 'package:cousre_code/shared/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  Color background=Colors.blue,
  double width =double.infinity,
  double radius=0,
  @required Function function,
  @required String text,
})=>Container(
  width: width,
  child: MaterialButton(
    onPressed:function,
    child: Text(text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
  ),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(radius),
  ),
);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isPassword=false,
})=> TextFormField(
  validator:validate,
  obscureText: isPassword,
  controller: controller,
  keyboardType: type,
  onTap: onTap,
  onFieldSubmitted:onSubmit,
  onChanged:onChange,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix!=null? IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix)):null,
  ),
);

Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model["id"].toString(),),
  child: Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text("${model["time"]}"),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text("${model["title"]}",

                style: TextStyle(

                  fontSize: 25,

                  fontWeight: FontWeight.bold,

                ),),

              Text("${model["date"]}",

                style: TextStyle(

                ),),

            ],

          ),

        ),

        SizedBox(width: 20,),

        IconButton(

          icon: Icon(Icons.check_box),

          color: Colors.green,

          onPressed: (){

            AppCubit.get(context).updateData(

              status: "done",

              id: model["id"],

            );

          },

        ),

        IconButton(

          icon: Icon(Icons.archive,color: Colors.grey[700],),

          onPressed: (){

            AppCubit.get(context).updateData(

              status: "archived",

              id: model['id'],

            );

          },

        ),

      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model["id"],);
  },
);

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>WebViewScreen(article["url"]),
    ));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image:DecorationImage(

              fit: BoxFit.cover,

              image: NetworkImage("${article['urlToImage']}"),

            ),

          ),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text("${article['title']}",

                    style:Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text("${article['publishedAt']}",

                  style: TextStyle(

                    color: Colors.grey,

                  ),),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
Widget articleBuilder(list,context)=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(
        list[index],context
    ),
    separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    ),
    itemCount:10,
  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);