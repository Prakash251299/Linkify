// import 'package:cloud_firestore/cloud_firestore.dart';

// enum statusValues { sent, received, read, error}
class MesInfo {
  String? message;
  int? timestamp;
  String? sender;
  String? receiver;
  String? status;
  dynamic doc;
  String? type;
  

  MesInfo(
      {this.message, this.timestamp, this.sender, this.receiver, this.status, this.type});

  MesInfo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timestamp = json['timestamp'];
    sender = json['sender'];
    receiver = json['receiver'];
    status = json['status'];
    type = json['type'];
    doc = json['doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['status'] = this.status;
    data['type'] = this.type;
    data['doc'] = this.doc;
    return data;
  }
}