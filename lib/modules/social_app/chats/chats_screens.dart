import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/Social_App/social_user_model.dart';
import 'package:untitled/shared/componants/componant.dart';

import '../chat_detals/chat_detals_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: ((context, index) =>
                    BuildChatItem(SocialCubit.get(context).users[index],context)),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget BuildChatItem(SocialUserModel model, BuildContext context,) 
  => InkWell(
        onTap: () {
          navigatTo(context, ChatDetalsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
                // 'https://firebasestorage.googleapis.com/v0/b/fir-udem-41851.appspot.com/o/users%2Fimage_picker7682457390673889057.png?alt=media&token=5fbab26a-1594-4845-9cef-98d6587e9a8a') //SocialCubit.get(context).usermodel!.image.toString() ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  '${model.name} ',
                  
                  style: TextStyle(height: 1.4),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz, size: 20),
                ),
              ),
            ],
          ),
        ),
      );

}
