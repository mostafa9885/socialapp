import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'LayOut/social_layout.dart';
import 'Moduels/Social Login/social_login.dart';
import 'Network/Local/cache_helper.dart';
import 'Shared/Bloc Observer/bloc_observer.dart';
import 'Shared/Components/constant.dart';
import 'Shared/Cubit/Social Cubit/social_cuibt.dart';
import 'Shared/Style/themes.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message');
  print(message.data.toString());

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();

  var token = await FirebaseMessaging.instance.getToken();
  print('token: ${token}');

  FirebaseMessaging.onMessage.listen((event)
  {
    print('onMessage');
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on Message Opened App ');
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget = SocialLayoutHome();
  }
  else
  {
    widget = SocialLoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        //darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
