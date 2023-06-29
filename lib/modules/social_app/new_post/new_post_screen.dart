import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'dart:io';
import '../../../shared/componants/componant.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post ',
            actions: [
              defaultTextButton(
                  onPress: () {
                    var now = DateTime.now();
                    if (cubit.PostImage == null) {
                      cubit.CreatePost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      cubit.uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                  },
                  text: 'Post')
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  if (State is SocialCreatePostLoadinState ||
                      state is SocialUploadPostLoadinState)
                    LinearProgressIndicator(),
                  if (State is SocialCreatePostLoadinState ||
                      state is SocialUploadPostLoadinState)
                    SizedBox(
                      height: 70,
                    ),
                  Row(
                    children: [
                      if (cubit.usermodel!.image == null)
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                              ' https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU '), //NetworkImage(SocialCubit.get(context).usermodel!.image.toString() ),
                        ),
                      if (cubit.usermodel!.image != null)
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage:
                              NetworkImage(cubit.usermodel!.image.toString()),
                          //  ' https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU '), //NetworkImage(SocialCubit.get(context).usermodel!.image.toString() ),
                        ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                        'the name',
                        style: TextStyle(height: 1.4),
                      )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: textController,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: '... بم تفكر', border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (cubit.PostImage != null)
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: FileImage(cubit.PostImage!),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 50, right: 10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: 20.0,
                                      child: IconButton(
                                        color: Colors.black,
                                        onPressed: () {
                                          cubit.removePostImage();
                                        },
                                        icon: Icon(
                                          Icons.close_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              cubit.gitPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_outlined),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('add photo ')
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(onPressed: () {}, child: Text('#tags ')),
                      ),
                    ],
                  )
                ]),
                          ),
              ),
          
            ],
             ),
        );
      },
    );
  }
}
