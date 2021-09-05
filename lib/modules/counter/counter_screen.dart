import 'package:cousre_code/modules/counter/cubit/cubit.dart';
import 'package:cousre_code/modules/counter/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child:BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,state){
          if(state is CounterPlusState)print("Plus State");
          if(state is CounterMinusState)print("Minus State");
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter App"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text("MINUS",
                      style: TextStyle(fontSize: 25),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("${CounterCubit.get(context).counter}",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),),
                  ),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text("PLUS",
                      style: TextStyle(fontSize: 25),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

