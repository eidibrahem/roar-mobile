import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/Social_App/message_model.dart';
import 'package:untitled/models/Social_App/posr_model.dart';
import 'package:untitled/models/Social_App/social_user_model.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/settings/settins_screen.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../../modules/social_app/chats/chats_screens.dart';
import '../../../modules/social_app/users/user_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? usermodel;
  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      usermodel = SocialUserModel.fromJeson(value.data());
      emit(SocialGetUserSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> Titles = ['home', 'chats', 't', 'users', 'settings'];

  void changeBottomNav(int index) {
    if (index == 4) getUserData();
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangBottomNavState());
    }
  }

  File? ProfileImage;

  final picker = ImagePicker();
  Future gitProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagepickedSuccessState());
    } else {
      print('no image selected ');
      emit(SocialProfileImagepickedErrorState());
    }
  }

  File? CaverImage;

  Future gitCaverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CaverImage = File(pickedFile.path);
      emit(SocialCaverImagepickedSuccessState());
    } else {
      print('no image selected ');
      emit(SocialCaverImagepickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadinState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccessState());
        print('${value} ssssssssssssssssssssssss  ');
        UpdateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print('${error.toString()}  rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    });
  }

  String? CaverimgeUrl = '';
  void uploadCaverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadinState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CaverImage!.path).pathSegments.last}')
        .putFile(CaverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print('${value} ssssssssssssssssssssssss  ');
        UpdateUser(
          name: name,
          phone: phone,
          bio: bio,
          caver: value,
        );
      }).catchError((error) {
        emit(SocialUploadCaverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCaverImageErrorState());
      print('${error.toString()} rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    });
  }

  /* void UpdateUserImages({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadinState());
    if (CaverImage != null) {
      uploadCaverImage();
    } else if (ProfileImage != null) {
      uploadProfileImage(bio: bio, name: name, phone: phone);
    } else if (CaverImage != null && ProfileImage != null) {
    } else {
      UpdateUser(name: name, phone: phone, bio: bio);
    }
  } */

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? caver,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      isEmailVerified: false,
      bio: bio,
      image: image ?? usermodel!.image,
      caver: caver ?? usermodel!.caver,
      email: usermodel!.email,
      uId: usermodel!.uId,
      //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
      //  caver: CaverimgeUrl,
      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? PostImage;

  Future gitPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPostImagepickedSuccessState());
    } else {
      print('no image selected ');
      emit(SocialPostImagepickedErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(SocialRemovePostState());
  }

  void uploadPostImage({
    String? dateTime,
    String? text,
  }) {
    emit(SocialUploadPostLoadinState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print('${value} ssssssssssssssssssssssss  ');
        CreatePost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialUploadPostErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
      print('${error.toString()} rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    });
  }

  void CreatePost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadinState());

    PostModel model = PostModel(
      name: usermodel!.name,
      uId: usermodel!.uId,
      image: usermodel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,

      //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
      //  caver: CaverimgeUrl,
      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
    );
    emit(SocialCreatePostLoadinState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      print(' oooooooopppppppppppp');
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String?> postsId = [];
  List<int?> likes = [];
  void gitPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach(((element) {
        element.reference.collection('likes').get().then(((value) {
          likes.add(value.docs.length);
          print(element.id);
          posts.add(PostModel.fromJeson(element.data()));
          postsId.add(element.id);
        })).catchError((error) {});
      }));
      emit(SocialGetPostsSucessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
      print('00000000000111111111');
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
      print('00000000000${error.toString()}');
    });
  }
 // CacheHelper.saveData(
  //key: 'uId',
  String? Id =  CacheHelper.getData1( key: 'uId') ;
  List<SocialUserModel> users = [];
  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != usermodel?.uId &&element.data()['uId'] !=Id )
            users.add(SocialUserModel.fromJeson(element.data()));
        });
        emit(SocialGetAllUsersSucessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print('Handling a background message ${message.messageId}');
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void firebaseMessaging() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground');
      print('Message data:${message.data}');
      if (message.notification != null) {
        print('message contained a notification :${message.notification}');
        ShowToast(
            state: ToastStates.SUCCESS,
            text: message.notification!.title.toString());
      }
    });
  }

  static void initState() async {
    configOneSignel();
    final status = await OneSignal.shared.getDeviceState();
    final String? tokenId = status?.userId;
    print('tokenid === ');
    print('tokenId === ${tokenId}');
  }

  static void configOneSignel() {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId('eaf132bb-5d19-4f74-9806-d4cc6fc718a8');
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
      OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
        print("ON WILL DISPLAY IN APP MESSAGE ${message.jsonRepresentation()}");
      });
    });
  }

  void handleSendNotification(String? tokenId, String? heading, String? content,
      String? imgUrlString2) async {
    var playerId = '4cf75bba-3f16-4995-a619-b176a69ca8c8';

    var imgUrlString =
        "https://vaars.000webhostapp.com/MrNutella/logonutella.png";

     AndroidNotification? android;

    var notification = OSCreateNotification(
        playerIds: [tokenId.toString()],
        content: '${content.toString()}',
        heading: '${usermodel?.name.toString()}',
        iosAttachments: {"id1": imgUrlString.toString()},
        // bigPicture: imgUrlString2.toString(),
        androidLargeIcon: usermodel?.image.toString(),
        androidSmallIcon: imgUrlString2.toString(),
        buttons: [
          OSActionButton(text: "رد",id: "id1"),
          OSActionButton(text: "تميز كمقروءة", id: "id2")
        ]);

    await OneSignal.shared.postNotification(notification).then((value) {
      emit(SocialSendNotificationSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendNotificationErrorState(error));
    });
  }

  void sendMessage({
    required String reciverId,
    required String deteTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      recrverId: reciverId,
      dateTime: deteTime,
      text: text,
      senderId: usermodel?.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSucessState());
      print('send Sucess');
    }).catchError((eror) {
      emit(SocialSendMessageErrorState(eror));
      print('send $eror');
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(usermodel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSucessState());
      print('send Sucess');
    }).catchError((eror) {
      emit(SocialSendMessageErrorState(eror));
      print('send $eror');
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String? reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJeson(element.data()));
      });
      print('-----${messages.length}');
      emit(SocialGetAllUsersSucessState());
    });
  }

  Future<bool> downloudImge(String? postImage) async {
    bool isDownlouded = false;
    var imageId;

    
      sleep(
        Duration(seconds: 5),
      );
      
   
    imageId = await ImageDownloader.downloadImage(postImage ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU')
        .then((value) {
      emit(SocialDownloudImgeSucessState());
      isDownlouded = true;
    }).catchError((eror) {
      print('2222222$eror');
      emit(SocialDownloudImgeErrorState());
    });

    if (imageId == null) {
      return isDownlouded;
    }
    var path = await ImageDownloader.findPath(imageId);
    return isDownlouded;
  }
}
