import 'package:flutter/material.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/user_network.dart';

// Future<List<UserInfo>?> fetchAllFriends(context)async{
//   NetworkFunction _networkFunction = NetworkFunction();

//               /* If data updation needed in firebase then use the below code */
//               // await s.fetchInfo();

//               var numberOfUsers = 0;
//               // DateTime now = DateTime.now();
//               // var dateToday = now.day.toString();
//               // if(_isNumeric(StaticStore.dateStored[1])){

//               // }

//               // if(StaticStore.dateStored[0]==dateToday[0]){

//               // }

//               /* Get number of users for recommendation */
//               // numberOfUsers = await _networkFunction.getNumberOfUsers();

//               // StoreUserInfo _storeUserInfo = StoreUserInfo();
//               // _storeUserInfo.fetchCurrentUserInfo();
//               if (numberOfUsers >= 10) {
//                 /* If we have more users then like based friend recommendations will be provided */
//                 List<UserInfo>? userHavingSameInterests =
//                     await _networkFunction.fetchRecommendedUsersInfo();
//                 Navigator.pushReplacement(context,MaterialPageRoute(
//                   builder: (_) => NetworkUser(userHavingSameInterests),
//                 ));
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //   builder: (_) => NetworkUser(userHavingSameInterests),
//                 // ));
//               } else {
//                 /* All users of our application will be recommended */
//                 List<UserInfo>? allUsers =
//                     await _networkFunction.fetchAllUsersInfo();
//                 // print(allUsers[0]?.id);

//                 Navigator.pushReplacement(context,MaterialPageRoute(
//                   builder: (_) => NetworkUser(allUsers!),
//                 ));
// }
// }

Future<List<UserInfo>?> fetchAllFriends() async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? allUsers = await _networkFunction.fetchAllUsersInfo();
  return allUsers;
}

Future<List<UserInfo>?> fetchBestMatchFriends() async {
  NetworkFunction _networkFunction = NetworkFunction();
  List<UserInfo>? bestMatch = await _networkFunction.fetchRecommendedUsersInfo();
  return bestMatch;
}


// Future<List<UserInfo>?> fetchGoodMatchFriends()async{
//   NetworkFunction _networkFunction = NetworkFunction();
//   List<UserInfo>? goodMatch;
//   return goodMatch;
// }