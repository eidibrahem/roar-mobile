class MessageModel {
  String? recrverId;
  String? dateTime;

  String? senderId;
  String? text;
  MessageModel({this.recrverId, this.senderId, this.text, this.dateTime});
  MessageModel.fromJeson(Map<String, dynamic?>? json) {
    recrverId = json!['recrverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recrverId'] = this.recrverId;
    data['senderId'] = this.senderId;
    data['text'] = this.text;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
