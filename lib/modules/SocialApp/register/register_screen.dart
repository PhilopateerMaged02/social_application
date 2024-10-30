import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/SocialApp/register/cubit/cubit.dart';
import 'package:social_app/modules/SocialApp/register/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (BuildContext context, SocialRegisterStates state) {
          if (state is SocialCreateUserSuccessState) {
            navigateToandKill(context, SocialLayout());
          }
        },
        builder: (BuildContext context, SocialRegisterStates state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create a new Account',
                        style: TextStyle(
                          fontFamily: 'Jannah',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: nameController,
                          input: TextInputType.name,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          text: 'User Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          input: TextInputType.emailAddress,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          text: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          input: TextInputType.text,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                          },
                          text: 'Password',
                          prefix: Icons.lock,
                          //suffix: Icons.remove_red_eye,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          onSuffix: () {
                            SocialRegisterCubit.get(context).changeVisibility();
                          },
                          isObscure:
                              SocialRegisterCubit.get(context).visibility),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          input: TextInputType.phone,
                          onValidator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          text: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      isEmailVerified: false);
                                }
                              },
                              text: 'REGISTER');
                        },
                        fallback: (BuildContext context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
