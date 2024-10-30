import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/SocialApp/Login/cubit/states.dart';
import 'package:news_app/modules/SocialApp/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  //object of the class
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility()
  {
    visibility = !visibility;
    suffix = visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}