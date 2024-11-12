import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/modules/SocialApp/Login/cubit/states.dart';
import 'package:social_app/modules/SocialApp/register/cubit/states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  //object of the class
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // void userRegister({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String password,
  //   required bool isEmailVerified,
  // }) {
  //   emit(SocialRegisterLoadingState());
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //     userCreate(
  //       name: name,
  //       email: email,
  //       phone: phone,
  //       uId: value.user!.uid,
  //     );
  //     print(value.user!.email);
  //     print(value.user!.uid);
  //     print(value.user!.displayName);
  //     //emit(SocialRegisterSuccessState());
  //   }).catchError((error) {
  //     emit(SocialRegisterErrorState(error.toString()));
  //   });
  // }

  void userRegisterSupa({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SocialRegisterLoadingState());

    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'Display name': name, 'Phone': phone},
      );

      if (res.user != null && res.session != null) {
        // If sign-up is successful, create the user in Firestore
        userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: res.user!.id,
        );
        emit(SocialRegisterSuccessState());
      } else {
        // Log additional information for debugging
        debugPrint('Sign-up failed: session or user is null');
        emit(SocialRegisterErrorState(
            "Failed to register user: session or user is null"));
      }
    } catch (error) {
      // Log the error to the console for debugging
      debugPrint('Error during registration: $error');
      emit(SocialRegisterErrorState(error.toString()));
    }
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        cover:
            "https://img.freepik.com/free-photo/young-person-presenting-empty-copyspace_1048-17665.jpg?t=st=1730562700~exp=1730566300~hmac=20225cb1a5b90cc9597b2516588bfa96e3c16ca82c1546d559e49f11600838c9&w=1480",
        bio: "Write your Bio....",
        image:
            "https://img.freepik.com/free-photo/3d-render-little-boy-with-jacket-jeansie_1142-57736.jpg?ga=GA1.1.960460351.1727711267",
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool visibility = true;
  IconData suffix = Icons.visibility_outlined;
  void changeVisibility() {
    visibility = !visibility;
    suffix =
        visibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
