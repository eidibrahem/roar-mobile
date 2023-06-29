abstract class SocialStates {}

class SocialIntialState extends SocialStates {}

class SocialGetUserLodingState extends SocialStates {}

class SocialGetUserSucessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String? error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLodingState extends SocialStates {}

class SocialGetAllUsersSucessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String? error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialChangBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagepickedSuccessState extends SocialStates {}

class SocialProfileImagepickedErrorState extends SocialStates {}

class SocialCaverImagepickedSuccessState extends SocialStates {}

class SocialCaverImagepickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SociaUploadCaverImageSuccessState extends SocialStates {}

class SocialUploadCaverImageErrorState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserLoadinState extends SocialStates {}

class SocialCreatePostLoadinState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String erorr;
  SocialLikePostErrorState(this.erorr);
}

class SocialPostImagepickedSuccessState extends SocialStates {}

class SocialPostImagepickedErrorState extends SocialStates {}

class SocialUploadPostLoadinState extends SocialStates {}

class SocialUploadPostSuccessState extends SocialStates {}

class SocialUploadPostErrorState extends SocialStates {}

class SocialRemovePostState extends SocialStates {}

class SocialGetPostsLodingState extends SocialStates {}

class SocialGetPostsSucessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String? error;
  SocialGetPostsErrorState(this.error);
}
class SocialSendMessageSucessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String? error;
  SocialSendMessageErrorState(this.error);
}
class SocialGetMessagesSucessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {
  final String? error;
  SocialGetMessagesErrorState(this.error);
}
class SocialSendNotificationSucessState extends SocialStates {}

class SocialSendNotificationErrorState extends SocialStates {
  final String? error;
  SocialSendNotificationErrorState(this.error);
}
class SocialDownloudImgeSucessState extends SocialStates {}
class SocialDownloudImgeErrorState extends SocialStates {}


//class SocialIntialState extends SocialStates {}
