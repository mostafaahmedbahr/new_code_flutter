import 'package:conditional_builder/conditional_builder.dart';
 import 'package:cousre_code/modules/done_tasks/done_tasks.dart';
import 'package:cousre_code/modules/new_tasks/new_tasks.dart';
import 'package:cousre_code/shared/componants/componants.dart';
 import 'package:cousre_code/shared/cubit/cubit.dart';
import 'package:cousre_code/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
class TodoApp extends StatelessWidget
{
  var titleController=TextEditingController();
  var  timeController=TextEditingController();
  var dateController=TextEditingController();
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        } ,
        builder: (context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body:ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder:(context)=>cubit.screens[cubit.currentIndex] ,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fanIcon),
              onPressed: ()
              {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState.validate())
                  {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                }
                else
                {
                  scaffoldKey.currentState.showBottomSheet((context)
                  =>Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (String value){
                              if(value.isEmpty){
                                return "title must not be empty";
                              }
                              return null;
                            },
                            label: "Task Title",
                            prefix: Icons.title,
                          ),
                          SizedBox(height: 15,),
                          defaultFormField(
                            onTap: (){
                              showTimePicker(
                                context: context,
                                initialTime:TimeOfDay.now(),
                              ).then((value){
                                timeController.text=value.format(context).toString();
                                print(value.format(context));
                              });
                            },
                            controller: timeController,
                            type: TextInputType.datetime,
                            validate: (String value){
                              if(value.isEmpty){
                                return "time must not be empty";
                              }
                              return null;
                            },
                            label: "Task Time",
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(height: 15,),
                          defaultFormField(
                            onTap: (){
                              showDatePicker(
                                context: context,
                                initialDate:DateTime.now() ,
                                firstDate:DateTime.now()  ,
                                lastDate: DateTime.parse("2021-11-25"),
                              ).then((value){
                                dateController.text=DateFormat.yMMMd().format(value);
                                print(DateFormat.yMMMd().format(value));
                              });
                            },
                            controller: dateController,
                            type: TextInputType.datetime,
                            validate: (String value){
                              if(value.isEmpty){
                                return "date must not be empty";
                              }
                              return null;
                            },
                            label: "Task Date",
                            prefix: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ).closed.then((value){
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (int index){
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<String> getName()async
  {
    return "mostafa bahr";
  }

}



