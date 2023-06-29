abstract class SocialLoginStates {}

// Login
class SocialLoginIntialState extends SocialLoginStates {}

class SocialLogLodingState extends SocialLoginStates {}

class SocialLoginSucccessState extends SocialLoginStates {
  final String? uId;
  SocialLoginSucccessState(this.uId);
}

class SocialLoginErorrState extends SocialLoginStates {
  final String error;
  SocialLoginErorrState(this.error);
}

// Regester
class SocialRegesterLodingState extends SocialLoginStates {}

class SocialRegesterSucccessState extends SocialLoginStates {
  SocialRegesterSucccessState();
}

class SocialRegesterErorrState extends SocialLoginStates {
  final String error;
  SocialRegesterErorrState(this.error);
}

// CreateUser
class SocialCreateUserLodingState extends SocialLoginStates {}

class SocialCreateUserSucccessState extends SocialLoginStates {
  SocialCreateUserSucccessState();
}

class SocialCreateUserErorrState extends SocialLoginStates {
  final String error;
  SocialCreateUserErorrState(this.error);
}

class SocialLoginChangePasssVisibilityState extends SocialLoginStates {}
