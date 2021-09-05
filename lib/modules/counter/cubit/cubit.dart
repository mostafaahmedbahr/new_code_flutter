import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../states.dart';
class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit():super(CounterInitialState());
  static CounterCubit get(context)=>BlocProvider.of(context);
  int counter=1;
  void minus(){
    emit(CounterMinusState());
    counter--;
  }
  void plus(){
    emit(CounterPlusState());
    counter++;
  }

}