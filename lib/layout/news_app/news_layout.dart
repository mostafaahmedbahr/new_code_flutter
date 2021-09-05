import 'package:cousre_code/layout/news_app/cubit/cubit.dart';
import 'package:cousre_code/layout/news_app/cubit/states.dart';
import 'package:cousre_code/modules/search/search.dart';
 import 'package:cousre_code/network/remote/dio_helper.dart';
import 'package:cousre_code/shared/cubit/cubit.dart';
import 'package:cousre_code/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>SearchScreen(),
                  ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
