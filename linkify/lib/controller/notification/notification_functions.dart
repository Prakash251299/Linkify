// import 'package:firebase_core/firebase_core.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/model/user_info.dart';

Future<List<UserInfo>?> FetchRequestNotifications(friendRequests)async{
  // FirebaseCall _firebaseCaller = FirebaseCall();
  NetworkFunction _fetchUserInfo = NetworkFunction();
  List<UserInfo>? _userInfo=[];
  for(int i=0;i<friendRequests?.length;i++){
    UserInfo temp = await _fetchUserInfo.fetchUserInfo(friendRequests[i]);
    _userInfo.add(temp);
  }
  // print(_userInfo);
  return _userInfo;
}

Future<void>acceptFriendRequest(userId)async{
  print("friend request accepted");
  // FirebaseCall _firebaseCaller = FirebaseCall();
  await updateRequestStatus("1",userId);
  await deleteFriendRequest(userId);
}

Future<void>rejectFriendRequest(userId)async{
  print("friend request rejected");
  // FirebaseCall _firebaseCaller = FirebaseCall();
  await updateRequestStatus("0",userId);
  await deleteFriendRequest(userId);

}