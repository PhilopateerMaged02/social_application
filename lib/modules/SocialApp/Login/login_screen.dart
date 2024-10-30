import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/SocialApp/Login/cubit/cubit.dart';
import 'package:news_app/modules/SocialApp/Login/cubit/states.dart';
import 'package:news_app/modules/SocialApp/register/register_screen.dart';
import 'package:news_app/shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (BuildContext context, SocialLoginStates state)
        {
          if (state is SocialLoginSuccessState)
          {
          }
        },
        builder: (BuildContext context, SocialLoginStates state) =>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jannah',
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('login now to browse our hot offers' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jannah',
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: emailController,
                          input: TextInputType.emailAddress,
                          onValidator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Email must not be empty';
                            }
                          },
                          text: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(height: 40,),
                      defaultFormField(
                        controller: passwordController,
                        input: TextInputType.text,
                        onValidator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Password must not be empty';
                          }
                        },
                        text: 'Password',
                        prefix: Icons.lock_outlined,
                        suffix: SocialLoginCubit.get(context).suffix,
                        onFieldSubmitted: (value)
                        {
                          // if(formKey.currentState!.validate())
                          // {
                          //   SocialLoginCubit.get(context).loginUser(
                          //       email: emailController.text,
                          //       password: passwordController.text);
                          // }
                        },
                        onSuffix: ()
                        {
                          SocialLoginCubit.get(context).changeVisibility();
                        },
                        isObscure: SocialLoginCubit.get(context).visibility,
                      ),
                      SizedBox(height: 40,),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (BuildContext context)
                        {
                          return defaultButton(
                              function: ()
                              {
                                // if(formKey.currentState!.validate())
                                // {
                                //   SocialLoginCubit.get(context).loginUser(
                                //       email: emailController.text,
                                //       password: passwordController.text);
                                // }
                              },
                              text: 'LOGIN');
                        },
                        fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text('Create an account',style: TextStyle(color: Colors.blue),))
                        ],
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