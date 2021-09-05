import 'package:conditional_builder/conditional_builder.dart';
import 'package:cousre_code/shared/componants/componants.dart';
 import 'package:cousre_code/shared/cubit/cubit.dart';
import 'package:cousre_code/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks=AppCubit.get(context).doneTasks;
        return ConditionalBuilder(
          condition: tasks.length>0,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(
                tasks[index],
                context
            ),
            itemCount: tasks.length,
            separatorBuilder: (context,index)=>Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),

          ),
          fallback:(context)=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 80,
                  color: Colors.grey,
                ),
                Text(
                  "No Tasks yet, Please Add Some Tasks...",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),),
              ],
            ),
          ) ,
        );
      },
    );
  }
}
