import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/Social_App/message_model.dart';
import 'package:untitled/models/Social_App/social_user_model.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../../shared/componants/componant.dart';

class ChatDetalsScreen extends StatelessWidget {
  ChatDetalsScreen(this.userModel);
  SocialUserModel? userModel;
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(reciverId: userModel!.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(userModel!.image.toString()),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel!.name.toString(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                titleSpacing: 0.0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, Widget);
                    },
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.deepOrangeAccent,
                    )),
              ),
              body:    Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).usermodel?.uId ==
                                  message.senderId) {
                                return (buildMyMessage(message));
                              }
                              return (buildMessage(message));
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,

                                ),
                            itemCount:
                                SocialCubit.get(context).messages.length),
                      ),
                      Container(
                        
                        height: 47,
                        
                         
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 224, 224, 224),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ..',
                                ),
                              ),
                            ),
                            Container(
                              height: 47,
                              color: const Color.fromARGB(255, 20, 116, 194),
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.sendMessage(
                                      reciverId: userModel!.uId.toString(),
                                      deteTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  
                                  cubit.handleSendNotification(userModel?.tokenId,userModel?.name,messageController.text,userModel?.image);
                                  messageController.text = '';
                                },

                                minWidth: 1,
                                // ignore: prefer_const_constructors
                                child: Icon(
                                  Icons.send_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              
              );
        },
      );
    });
  }

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text(model.text.toString())),
      );
  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.shade200,
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  topStart: Radius.circular(10.0),
                )),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Text(model.text.toString())),
      );
}
