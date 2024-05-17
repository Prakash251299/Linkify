import 'package:flutter/material.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/user_network.dart';

Future<List<UserInfo>?> fetchAllFriends(numberOfUsers) async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? allUsers = await _networkFunction.fetchAllUsersInfo(numberOfUsers);
  return allUsers;
}

Future<List<UserInfo>?> fetchBestMatchFriends(numberOfUsers) async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? bestMatch = await _networkFunction.fetchRecommendedUsersInfo(numberOfUsers);
  return bestMatch;
}


Future<List<UserInfo>?> fetchGoodMatchFriends(numberOfUsers)async{
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? goodMatch;
  return goodMatch;
}
