class PostModel {
  String? name;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? uId;

  
  PostModel(
      {this.name,
      this.text,
      this.postImage,
      this.uId,
      this.dateTime,
      this.image
      });
  PostModel.fromJeson(Map<String, dynamic?>? json) {
    name = json!['name'];
    text = json['text'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['text'] = this.text;
    data['postImage'] = this.postImage;
    data['uId'] = this.uId;
    data['image'] = this.image;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
