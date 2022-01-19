

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp3/Shared/Colors%20and%20Icons/colors_icons.dart';

import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  IconData suffixIcon = IconAPP.visibilityIcon;

  void changeVisibilityIcon ()
  {
    isVisible = !isVisible;
    suffixIcon = isVisible? IconAPP.visibilityIcon : IconAPP.visibilityOffIcon;
    emit(ChangeVisibleIconPasswordState());
  }


  void userLogin ({
    required String email,
    required String password,
  })
  {

    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(SocialLoginErrorState(onError.toString()));
    });
  }

}