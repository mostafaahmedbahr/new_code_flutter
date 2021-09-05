import 'package:cousre_code/layout/news_app/cubit/cubit.dart';
import 'package:cousre_code/layout/news_app/cubit/states.dart';
import 'package:cousre_code/shared/componants/componants.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (String value){
                    if(value.isEmpty)
                    {
                      return"search must not be empty";
                    }
                    else
                    {
                      return null;
                    }
                  },
                  label: "Search",
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: articleBuilder(list,context),
              ),
            ],
          ),
        );
      },
    );
  }
}
