
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
import 'package:socialapp3/Moduels/User%20Profile/user_profile.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Register%20Cubit/register%20states.dart';
import 'package:socialapp3/Shared/Cubit/Register%20Cubit/register_cubit.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_cuibt.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreatUserSuccessState)
          {
            NavigateAnfFinish(context, SocialLayoutHome());
          }
        },
        builder: (context, state)
        {

          var cubit = RegisterCubit.get(context);

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
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: ColorApp.blackColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        D_TextFromField(
                            controller: nameController,
                            label: 'Name',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconBroken.user,
                            keyboardType: TextInputType.text,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Enter You\'r Name';}
                            }
                        ),
                        const SizedBox(height: 15),
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
                              if(value!.isEmpty){return 'Password is to Short';}
                            },
                            suffixIcon: cubit.suffix,
                            isobscureText: cubit.isVisibility,
                            suffixPressed: ()
                            {
                              cubit.changeVisibility();
                            }
                        ),
                        const SizedBox(height: 15),
                        D_TextFromField(
                            controller: phoneController,
                            label: 'Phone',
                            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                            prefixIcon: IconBroken.call,
                            keyboardType: TextInputType.phone,
                            validator: (value)
                            {
                              if(value!.isEmpty){return 'Enter you\'r Phone';}
                            }
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => D_MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.UserRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              text: 'register',
                              fontWeight: FontWeight.w900,
                              width: double.infinity,
                              backgroundColorButton: ColorApp.mainColor
                          ),
                          fallback: (context) =>  const Center(child: CircularProgressIndicator(),),
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
