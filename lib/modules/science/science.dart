import 'package:conditional_builder/conditional_builder.dart';
import 'package:cousre_code/layout/news_app/cubit/cubit.dart';
import 'package:cousre_code/layout/news_app/cubit/states.dart';
import 'package:cousre_code/shared/componants/componants.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Science extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).science;
        return articleBuilder(list,context);
      },
    );
  }
}
