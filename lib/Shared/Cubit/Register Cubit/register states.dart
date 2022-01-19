
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class ChangeVisibilityPassword extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates
{

  final String onError;

  RegisterErrorState(this.onError);

}

class SocialCreatUserSuccessState extends RegisterStates {}

class SocialCreatUserErrorState extends RegisterStates
{

  final String onError;

  SocialCreatUserErrorState(this.onError);

}