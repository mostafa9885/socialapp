
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';
import 'package:socialapp3/Shared/Cubit/Register%20Cubit/register%20states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisibility = true;
  IconData suffix = IconAPP.visibilityIcon;

  void changeVisibility()
  {
    isVisibility = !isVisibility;
    suffix = isVisibility? IconAPP.visibilityIcon : IconAPP.visibilityOffIcon;
    emit(ChangeVisibilityPassword());
  }


  void UserRegister({
    required String name,
    required String email,
    required dynamic password,
    required String phone,
})
  {

    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);

      userCreat(
        uId:value.user!.uid,
        phone: phone,
        email: email,
        name: name
      );

    }).catchError((onError)
    {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }


  void userCreat({
    required String name,
    required String email,
    required String phone,
    required String uId,
})
  {

    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
      cover: 'https://images.pexels.com/photos/587063/pexels-photo-587063.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      bio: 'Write your bio...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
          {
            emit(SocialCreatUserSuccessState());
          })
        .catchError((onError)
          {
            print(onError.toString());
            emit(SocialCreatUserErrorState(onError.toString()));
          });
  }
}