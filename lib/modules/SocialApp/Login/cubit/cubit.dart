import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/SocialApp/Login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());
  //object of the class
  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility()
  {
    visibility = !visibility;
    suffix = visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}