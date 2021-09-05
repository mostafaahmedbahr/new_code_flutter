import 'package:bloc/bloc.dart';
import 'package:cousre_code/modules/archived_task/archived_task.dart';
import 'package:cousre_code/modules/done_tasks/done_tasks.dart';
import 'package:cousre_code/modules/new_tasks/new_tasks.dart';
import 'package:cousre_code/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  Database database;
  bool isBottomSheetShown=false;
  IconData fanIcon=Icons.edit;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  List<String>titles=[
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  List<Widget>screens=[
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()
  {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database,version)
      {
        print("database is created");
        database.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)").then((value){
          print("table created");
        }).catchError((error){
          print("${error.toString()},");
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database);
        print("database is opened");
      },
    ).then((value){
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  })async
  {
    await database.transaction((txn)
    {
      txn.rawInsert(
        "INSERT INTO tasks(title,date,time,status) VALUES('$title','$date','$time','new')",
      ).then((value){
        print("$value insert successfully");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error){
        print(error.toString());
      });
      return null;
    },);
  }

  void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value){
      value.forEach((element) {
        if(element["status"]=="new")
        {
          newTasks.add(element);
        }
        else if(element["status"]=="done")
        {
          doneTasks.add(element);
        }
        else archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void changeBottomSheetState
      ({
    @required bool isShow,
    @required IconData icon,
  })
  {
    isBottomSheetShown=isShow;
    fanIcon=icon;
    emit(AppChangeBottomSheetState());
  }
  void updateData({
    @required String status,
    @required int id,
  })async
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id,],
    ).then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }
  void deleteData({
    @required int id,
  })async
  {
    database.rawDelete(

      'DELETE FROM tasks WHERE id = ?',[id],

    ).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark=false;
  void changeAppMode()
  {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

}