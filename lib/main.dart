import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/onboarding/on_boarding.dart';
import 'package:untitled/modules/social_app/star_screen/notifications.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/stats.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/shared/styles/themes.dart';

import 'layout/news_app/news_layout.dart';
import 'layout/social_app/cubit/states.dart';
import 'modules/shop_app/login/cubit/cubit.dart';
import 'modules/social_app/social_login/cubit/cubit.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options:  DefaultFirebaseOptions.currentPlatform ,

      );
   SocialCubit.initState();
  var token1 = await FirebaseMessaging.instance.getToken();
  final status = await OneSignal.shared.getDeviceState();
  final String? tokenId = status?.userId;
   
  print('token === ${token1}');
  print('tokenId === ${tokenId}');
  
 

  DioHelper.init();
  DioHelper.inith();
  await CacheHelper.init();
  final Widget? widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onbording = CacheHelper.getData1(key: 'onBoarding');
  // if (CacheHelper.getData1(key: 'token') != null)
  // token = CacheHelper.getData1(key: 'token');

  uId = CacheHelper.getData1(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

Future<ValueNotifier<Color>> initSettings() async {
  final _accentColor = ValueNotifier(Colors.blueAccent);
  return _accentColor;
}

bool _isDarkTheme = true;
bool _isUsingHive = true;

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  final bool? isDark;
  //final bool? onBoarding;
  final Widget? startWidget;
  //bool onboarding = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..changeAppMode(fromShared: isDark),
          ),
          BlocProvider(
              create: (context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesData()),
          BlocProvider(create: (context) => SocialLoginCubit()),
          //getUserData
          BlocProvider(
              create: (context) => SocialCubit()
                ..getUserData()
                ..gitPosts()),
        ],
        child: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              //if (onBoarding == null)
              // onboarding = false;
              //else
              // onboarding = true;
              return MaterialApp(
                title: 'Roar app',
                theme: lightTheme2,
                themeMode: ThemeMode.light,
                darkTheme: darkTheme,
                home:startWidget!,
                   // startWidget!, // onboarding ? ShopLoginScreen() : onBoardingScreen(),
                debugShowCheckedModeBanner: false,
              );
            }));
  }
}
