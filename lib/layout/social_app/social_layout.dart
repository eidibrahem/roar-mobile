import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/shared/componants/componant.dart';

import '../../modules/social_app/notifictions/notifications.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        Timer(Duration(seconds: 5), () {
 
            SocialCubit()
                ..getUserData()
                ..gitPosts();
        });
        if (state is SocialNewPostState) {
          navigatTo(context, NewPostScreen());
        }

      },
      builder: ((context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    navigatTo(context, Notifications());
                  },
                  icon: Icon(
                    Icons.notification_add_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search_rounded, color: Colors.white))
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined), label: 'chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline_rounded), label: 'post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'setting'),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      }),
    );
  }
}
/*ConditionalBuilder(
              condition: SocialCubt.get(context).model != null,
              builder: ((context) {
                var model = SocialCubt.get(context).model;
                return Column(children: [
                  
                    ]);
              }),
              fallback: ((context) =>
                  Center(child: CircularProgressIndicator()))),*/