class SocialUserModel {
  String? name;
  String? image;
  String? caver;
  String? email;
  String? phone;
  String? uId;
  String? tokenId;
  String? bio;
  bool? isEmailVerified;
  SocialUserModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this. tokenId,
      this.isEmailVerified,
      this.bio,
      this.caver,
      this.image});
  SocialUserModel.fromJeson(Map<String, dynamic?>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    tokenId = json['tokenId'];
    image = json['image'];
    bio = json['bio'];
    caver = json['caver'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['tokenId'] = this.tokenId;
    data['uId'] = this.uId;
    data['bio'] = this.bio;
    data['isEmailVerified'] = this.isEmailVerified;
    data['image'] = this.image;
    data['caver'] = this.caver;
    return data;
  }
}
