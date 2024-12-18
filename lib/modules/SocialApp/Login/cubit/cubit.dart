//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/SocialApp/Login/cubit/states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());
  //object of the class
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(SocialLoginLoadingState());
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //     emit(SocialLoginSuccessState(value.user!.uid, uId: '${value.user!.uid}'));
  //   }).catchError((error) {
  //     emit(SocialLoginErrorState(error.toString()));
  //   });
  // }

  void userLoginSupa({
    required String email,
    required String password,
  }) async {
    emit(SocialLoginLoadingState());
    final Null res = await supabase.auth
        .signInWithPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.id, uId: '${value.user!.id}'));
      uId = value.user!.id;
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
    final Session? session = res!.session;
    final User? user = res!.user;
  }

  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility() {
    visibility = !visibility;
    suffix =
        visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}
