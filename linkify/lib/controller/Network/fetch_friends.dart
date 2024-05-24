import 'package:flutter/material.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/friend_suggestion.dart';
import 'package:linkify/widgets/Network/user_network.dart';

Future<List<UserInfo>?> fetchAllFriends(int numberOfUsers) async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? allUsers =
      await _networkFunction.fetchAllUsersInfo(numberOfUsers);
  return allUsers;
}

Future<List<UserInfo>?> fetchBestMatchFriends(int numberOfUsers) async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? bestMatch =
      await _networkFunction.fetchRecommendedUsersInfo(numberOfUsers);
  return bestMatch;
}

Future<List<UserInfo>?> fetchGoodMatchFriends(int numberOfUsers) async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? goodMatch;
  return goodMatch;
}

Future<void> getRequestStatus(
    List<UserInfo>? users, int recommendaionIndex) async {
  // List<dynamic>
  List<String>? temp = [];
  temp = StaticStore.requestStatusValue?[recommendaionIndex];
  if (users != null) {
    print("bestmatch has data");
    for (int i = 0; i < 3 && i < users.length; i++) {
      temp?.add(await getFriendStatus(users[i].id));
    }
    StaticStore.requestStatusValue?.add(temp);
  } else {
    StaticStore.requestStatusValue?.add([]);
  }
}

Future<List<List<UserInfo>?>> userButtonCaller() async {
  StaticStore.requestStatusValue?.clear();
  StaticStore.requestStatusValue = [[], [], []];
  List<UserInfo>? bestMatch = await fetchBestMatchFriends(3);
  List<UserInfo>? goodMatch = await fetchGoodMatchFriends(3);
  List<UserInfo>? allUsers = await fetchAllFriends(3);

  await getRequestStatus(bestMatch, 0);
  await getRequestStatus(goodMatch, 1);
  await getRequestStatus(allUsers, 2);

  // print(StaticStore.requestStatusValue);
  // Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => Suggestion(bestMatch, goodMatch, allUsers)));
      return [bestMatch,goodMatch,allUsers];
}
