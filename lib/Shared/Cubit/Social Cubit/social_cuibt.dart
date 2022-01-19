
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp3/Models/Message%20Model/message_model.dart';
import 'package:socialapp3/Models/Post%20Model/post_model.dart';
import 'package:socialapp3/Models/User%20Creat%20Model/user_creat_model.dart';
import 'package:socialapp3/Moduels/Bottom%20Navigator/Chats/chat_screen.dart';
import 'package:socialapp3/Moduels/Bottom%20Navigator/Home/home_screen.dart';
import 'package:socialapp3/Moduels/Bottom%20Navigator/Profile/profile_screen.dart';
import 'package:socialapp3/Moduels/Bottom%20Navigator/Users/users_screen.dart';
import 'package:socialapp3/Moduels/Settings/settings_screen.dart';
import 'package:socialapp3/Moduels/Social%20Login/social_login.dart';
import 'package:socialapp3/Network/Local/cache_helper.dart';
import 'package:socialapp3/Shared/Components/components.dart';
import 'package:socialapp3/Shared/Components/constant.dart';
import 'package:socialapp3/Shared/Cubit/Social%20Cubit/social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> title =
  [
    'News Feed',
    'Chat',
    'Profile',
    'Users',
    'Setting',
  ];

  List<Widget> screens =
  [
    HomeScreen(),
    ChatScreen(),
    ProfileScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(SocialChangeIndexBottomNavState());

    // if(index == 2)
    // {
    //   emit(SocialAddNewPostState());
    // }
    // else
    // {
    //   currentIndex = index;
    //   emit(SocialChangeIndexBottomNavState());
    // }
  }

  int postCurrentIndex = 0;

  void changePostBottomNavIndex(int index) {
    postCurrentIndex = index;
    emit(SocialChangeIndexPostScreenBottomNavState());
  }

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = SocialUserModel(
        image: 'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
        cover: 'https://images.pexels.com/photos/587063/pexels-photo-587063.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
        bio: 'Write your bio...',
        name: 'User',
        email: "",
        phone: "",
        uId: uId,
        isEmailVerified: false,
      );
      model = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetUserDataSuccessState());
    })
        .catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserDataErrorState(onError.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else {
      print('No image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else {
      print('No image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  //String profileImageUrl = '';
  void uploadProfileImage({
    String? bio,
    String? name,
    String? phone,
    String? email,
  }) {
    emit(SocialUploadProfileImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        //profileImageUrl = value;
        updateUser(
          name: model!.name,
          phone: model!.phone,
          bio: model!.bio,
          email: model!.email,
          image: value,
        );
        emit(SocialUploadProfileImageSuccessState());
      })
          .catchError((error) {});
    })
        .catchError((onError) {});
  }


  //String coverImageUrl = '';
  void uploadCoverImage({
    String? bio,
    String? name,
    String? phone,
    String? email,
  }) {
    emit(SocialUploadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        //coverImageUrl = value;
        updateUser(
          name: model!.name,
          phone: model!.phone,
          bio: model!.bio,
          email: model!.email,
          cover: value,
        );
        emit(SocialUploadCoverImageSuccessState());
      })
          .catchError((error) {});
    })
        .catchError((onError) {});
  }

  void updateUser({
    String? bio,
    String? name,
    String? phone,
    String? email,
    String? image,
    String? cover,
  }) {
    emit(SocialUserUpdateLoadingState());

    if (bio != null) {
      model = SocialUserModel(
        bio: bio,
        name: model!.name,
        phone: model!.phone,
        email: model!.email,
        image: image ?? model!.image,
        cover: cover ?? model!.cover,
        uId: model!.uId,
        isEmailVerified: false,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(model!.uId)
          .update(model!.toMap())
          .then((value) {
        getUserData();
      })
          .catchError((onError) {
        emit(SocialUserUpdateErrorState());
      });
    } else {
      model = SocialUserModel(
        bio: model!.bio,
        name: name,
        phone: phone,
        email: email,
        image: image ?? model!.image,
        cover: cover ?? model!.cover,
        uId: model!.uId,
        isEmailVerified: false,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(model!.uId)
          .update(model!.toMap())
          .then((value) {
        getUserData();
      })
          .catchError((onError) {
        emit(SocialUserUpdateErrorState());
      });
    }
  }


  File? postImage;

  Future<void> getPostImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else {
      print('No image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemoveSuccessState());
  }

  void uploadPostImage({
    String? dataTime,
    String? text,
  }) {
    emit(SocialCreatNewPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        creatPost(
          text: text,
          dataTime: dataTime,
          postImage: value,
        );
        //coverImageUrl = value;

        emit(SocialCreatNewPostSuccessState());
      })
          .catchError((error) {
        emit(SocialCreatNewPostErrorState(onError.toString()));
      });
    })
        .catchError((onError) {
      emit(SocialCreatNewPostErrorState(onError.toString()));
    });
  }

  void creatPost({
    String? dataTime,
    String? text,
    String? postImage,
  }) {
    emit(SocialCreatNewPostLoadingState());

    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dataTime: dataTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatNewPostSuccessState());
    })
        .catchError((onError) {
      print(onError.toString());
      emit(SocialCreatNewPostErrorState(onError.toString()));
    });
  }


  List<PostModel> posts = [];
  List<String> postsId = [];


  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dataTime', descending: true)
        .snapshots()
        .listen((value) async
    {
      posts = [];

      value.docs.forEach((element) async
      {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));

        await FirebaseFirestore.instance.collection('posts').doc(element.id)
            .update({'postId': element.id});
        emit(SocialGetPostSuccessState());
      });
    });
  }


  //
  // void likePost(String? postUid)
  // {
  //
  //   LikeModel likeModel = LikeModel(
  //     uId: model!.uId,
  //     image: model!.image,
  //     name: model!.name,
  //   );
  //
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postUid)
  //       .collection('like')
  //       .doc(model!.uId)
  //       .set(likeModel.toMap())
  //       .then((value)
  //         {
  //           emit(SocialLikePostSuccessState());
  //         })
  //       .catchError((onError)
  //         {
  //           print(onError.toString());
  //           emit(SocialLikePostErrorState(onError.toString()));
  //         });
  // }


  List<SocialUserModel> users = [];

  void getUsers() {
    users = [];
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != model!.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUserDataSuccessState());
    })
        .catchError((onError) {
      emit(SocialGetAllUserDataErrorState(onError.toString()));
    });
  }


  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: model!.uId,
      text: text,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((onError) {
      emit(SocialSendMessageErrorState(onError.toString()));
    });
  }


  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }


  SocialUserModel? profileModel;

  void getUserProfileData({required String userId}) {
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      profileModel = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetUserDataSuccessState());
    })
        .catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserDataErrorState(onError.toString()));
    });
  }


  void signOut(context) {
    emit(SignOutLoadingState());
    FirebaseAuth.instance
        .signOut()
        .then((value) async {
      CacheHelper.removeData(key: 'uId');
      await FirebaseMessaging
          .instance
          .deleteToken();
      await FirebaseFirestore
          .instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          if (element.id == model!.uId)
            element.reference.update({'token': null});
        });
      });
      NavigateAnfFinish(context, SocialLoginScreen());
      emit(SignOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SignOutErrorState(error.toString()));
    });
  }


}