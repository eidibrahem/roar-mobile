import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:untitled/models/Social_App/social_user_model.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/social_app/social_login/cubit/states.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';
import '../../../../shared/network/end_points.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginIntialState());
  static SocialLoginCubit git(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLogLodingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(SocialLoginSucccessState(value.user?.uid));
    }).catchError((Error) {
      emit(SocialLoginErorrState(Error.toString()));
    });
  }

  void emitState1() {
    emit(SocialLogLodingState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegesterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user?.uid);
      uId = value.user?.uid;
      emit(SocialLoginSucccessState(value.user?.uid));
      
    }).catchError((Error) {
      emit(SocialRegesterErorrState(Error.toString()));
    });
  }

  void userCreate({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
  })  async {
    var status = await OneSignal.shared.getDeviceState();
    String? tokenId = status?.userId;

    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio: 'write your bio',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
      caver:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOaCb-EnuPC_eM4Cfog9_G4mYAIj1yKswPgwk0RWcM9NRIHKCY8_SyO3g7HMsYskjRyBU&usqp=CAU',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSucccessState());
    }).catchError((error) {
      emit(SocialCreateUserErorrState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispass = true;
  void changePasssVisibility() {
    ispass = !ispass;
    if (ispass) {
      suffix = Icons.visibility_off_outlined;
    } else {
      suffix = Icons.visibility_outlined;
    }
    emit(SocialLoginChangePasssVisibilityState());
  }
}
