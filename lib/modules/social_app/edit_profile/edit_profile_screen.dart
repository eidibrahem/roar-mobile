import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/componants/componant.dart';

import '../../../shared/network/local/cache_helper.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? profileImage;
  File? CaverImage;
  ImageProvider? mainImage;
  ImageProvider C_Image = AssetImage('');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (SocialCubit.get(context).ProfileImage != null)
          mainImage = FileImage(SocialCubit.get(context).ProfileImage!);
        else
          mainImage =
              NetworkImage('${SocialCubit.get(context).usermodel?.image}');
        if (SocialCubit.get(context).CaverImage != null)
          C_Image = FileImage(SocialCubit.get(context).CaverImage!);
        else
          C_Image =
              NetworkImage('${SocialCubit.get(context).usermodel?.caver}');
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.usermodel;
        profileImage = cubit.ProfileImage;
        CaverImage = cubit.CaverImage;
        C_Image = NetworkImage('${cubit.usermodel?.image}');
        nameController.text =cubit.usermodel!.name.toString();
           // ' https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU ';
        //cubit.usermodel!.name.toString();
        bioController.text = cubit.usermodel!.bio.toString();
        phoneController.text = cubit.usermodel!.phone.toString();

        if (profileImage != null) {
          mainImage = FileImage(cubit.ProfileImage!);
        } else {
          mainImage = NetworkImage('${cubit.usermodel?.image}');
        }
        if (CaverImage != null) {
          C_Image = FileImage(cubit.CaverImage!);
        } else {
          C_Image = NetworkImage('${cubit.usermodel?.caver}');
        }

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                onPress: () {
                  cubit.UpdateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                text: 'Update',
                color: Colors.white),
            SizedBox(
              width: 15.0,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (state is SocialUpdateUserLoadinState)
                  LinearProgressIndicator(),
                if (state is SocialUpdateUserLoadinState)
                  SizedBox(
                    height: 10,
                  ),
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
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)),
                                  image: DecorationImage(
                                    image: C_Image,
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
                                      cubit.gitCaverImage();
                                    },
                                    icon:const Icon(
                                      Icons.camera_alt,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: mainImage,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    radius: 20.0,
                                    child: IconButton(
                                      color: Colors.black,
                                      onPressed: () {
                                        cubit.gitProfileImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (cubit.ProfileImage != null || cubit.CaverImage != null)
                  Row(
                    children: [
                      if (cubit.ProfileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  onPress: () {
                                    cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'upload profile',
                                  background: Colors.green),
                               if(state is SocialUpdateUserLoadinState ) 
                              SizedBox(
                                height: 5,
                              ),
                            if(state is SocialUpdateUserLoadinState )
                              LinearProgressIndicator()
                            ],
                          ),
                        ),
                    if (cubit.ProfileImage != null &&cubit.CaverImage != null)  
                      SizedBox(
                        width: 8,
                      ),
                      if (cubit.CaverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  onPress: () {
                                    cubit.uploadCaverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: 'upload caver',
                                  background: Colors.green),
                              if(state is SocialUpdateUserLoadinState )  
                              SizedBox(
                                height: 5,
                              ),
                               if(state is SocialUpdateUserLoadinState ) 
                              LinearProgressIndicator() 
                            ],
                          ),
                        ),
                    ],
                  ),
                if (cubit.ProfileImage != null || cubit.CaverImage != null)
                  SizedBox(
                    height: 20,
                  ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormFieldX(
                          Controller: nameController,
                          type: TextInputType.name,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 18),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.supervised_user_circle_outlined),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormFieldX(
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16),
                        Controller: bioController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'Bio',
                        prefix: Icons.info_outline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormFieldX(
                        Controller: phoneController,
                        type: TextInputType.phone,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 18),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone_android_outlined,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
