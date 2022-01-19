
abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

// GetUserData
class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates
{
  final String onError;

  SocialGetUserDataErrorState(this.onError);
}

//ChangeIndex
class SocialChangeIndexBottomNavState extends SocialStates {}

class SocialChangeIndexPostScreenBottomNavState extends SocialStates {}

//AddPost
class SocialAddNewPostState extends SocialStates {}

//ImagePicked
class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}


//UploadProfile&Cover
class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

//UpdateUserData
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//CreatPost
class SocialCreatNewPostLoadingState extends SocialStates {}

class SocialCreatNewPostSuccessState extends SocialStates {}

class SocialCreatNewPostErrorState extends SocialStates
{
  final String onError;

  SocialCreatNewPostErrorState(this.onError);
}

//PostImagePicked
class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialPostImageRemoveSuccessState extends SocialStates {}

//GetPost
class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates
{
  final String onError;

  SocialGetPostErrorState(this.onError);
}

//LikePost

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates
{
  final String onError;

  SocialLikePostErrorState(this.onError);
}

// GetAllUserData
class SocialGetAllUserDataLoadingState extends SocialStates {}

class SocialGetAllUserDataSuccessState extends SocialStates {}

class SocialGetAllUserDataErrorState extends SocialStates
{
  final String onError;

  SocialGetAllUserDataErrorState(this.onError);
}

//SendMessage
class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates
{
  final String onError;

  SocialSendMessageErrorState(this.onError);
}

//getMessage
class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageErrorState extends SocialStates
{
  final String onError;

  SocialGetMessageErrorState(this.onError);
}





// SignOut
class SignOutLoadingState extends SocialStates {}

class SignOutSuccessState extends SocialStates {}

class SignOutErrorState extends SocialStates
{
  final String onError;

  SignOutErrorState(this.onError);
}
