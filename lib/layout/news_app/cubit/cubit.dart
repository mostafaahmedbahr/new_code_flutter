import 'package:bloc/bloc.dart';
import 'package:cousre_code/layout/news_app/cubit/states.dart';
import 'package:cousre_code/modules/business/business.dart';
import 'package:cousre_code/modules/science/science.dart';
import 'package:cousre_code/modules/settings/settings.dart';
import 'package:cousre_code/modules/sports/sports.dart';
import 'package:cousre_code/network/remote/dio_helper.dart';
import 'package:cousre_code/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon:Icon(Icons.business),
      label:"Business" ,
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label:"Sports" ,
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.science),
      label:"Science" ,
    ),
  ];
  List<Widget> screens=[
    Business(),
    Sports(),
    Science(),
  ];
  List<dynamic>business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        "country":"eg",
        "category":"business",
        "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value)
    {
      business=value.data["articles"];
      print(business[0]["title"]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  ///
  ///
  List<dynamic>sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        "country":"eg",
        "category":"sports",
        "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value)
    {
      sports=value.data["articles"];
      print(sports[0]["title"]);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic>science=[];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{
        "country":"eg",
        "category":"science",
        "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value)
    {
      science=value.data["articles"];
      print(science[0]["title"]);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void changeBottomNavBar(int index){
    if(index==1){
      getSports();
    }
    else if(index==2){
      getScience();
    }
    currentIndex=index;
    emit(NewsBottomNavState());
  }
  List<dynamic>search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
      url: "v2/everything",
      query:{
        "q":"$value",
        "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value)
    {
      search=value.data["articles"];
      print(search[0]["title"]);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}