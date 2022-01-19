

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:socialapp3/LayOut/social_layout.dart';
import 'package:socialapp3/Models/Message%20Model/message_model.dart';
import 'package:socialapp3/Models/Post%20Model/post_model.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Moduels/Chat%20Detiels/chat_detials_screen.dart';
import 'package:socialapp3/Moduels/Edit%20Profile/edit_profile_screen.dart';
import 'package:socialapp3/Moduels/Edit%20Screens/Edit%20Bio/edit_bio_screen.dart';
import 'package:socialapp3/Moduels/Edit%20Screens/Edit%20Information/edit_information_screen.dart';
import 'package:socialapp3/Moduels/New%20Post/add_new_post_%20screen.dart';
import 'package:socialapp3/Moduels/Register/register_screen.dart';
import 'package:socialapp3/Moduels/User%20Profile/user_profile.dart';
import 'package:socialapp3/Network/Local/cache_helper.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/Toast%20Components/toast_components.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Loginl%20Cubit/login_cubit.dart';
import 'package:socialapp3/Shared/Cubit/Loginl%20Cubit/login_states.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class SocialLoginScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState)
          {
            toast(
                message: state.error,
                state: ToastState.ERROR,
                context: context
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
            ).then((value)
            {
              NavigateAnfFinish(context, SocialLayoutHome());

            });
          }
        },
        builder: (context, state)
        {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: ColorApp.blackColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        D_TextFromField(
                            controller: emailController,
                            label: 'Email Address',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconBroken.message,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Email Address not be Empty';}
                            }
                        ),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: passwordController,
                            label: 'Password',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconBroken.lock,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'inCorrect Password';}
                            },
                            suffixIcon: cubit.suffixIcon,
                            suffixPressed: ()
                            {
                              cubit.changeVisibilityIcon();
                            },
                            isobscureText: cubit.isVisible,
                            onSubmitted: (value)
                            {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => D_MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              text: 'login',
                              fontWeight: FontWeight.w900,
                              width: double.infinity,
                              backgroundColorButton: ColorApp.mainColor
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator(),),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text(
                              'Don\'t have an Account?',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            D_TextButton(
                                context: context,
                                onPressed: ()
                                {
                                  NavigatorTo(context, RegisterScreen());
                                },
                                text: 'Register Now!',
                                fontWeight: FontWeight.w800
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
