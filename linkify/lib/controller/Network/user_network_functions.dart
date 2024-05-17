import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/controller/get_user_info.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';

class NetworkFunction {
  Future<UserInfo> fetchUserInfo(var userId) async {
    var db = FirebaseFirestore.instance;
    UserInfo users = UserInfo();
    await db.collection("users").doc(userId).get().then((v) async {
      // UserInfo k = v.data() as UserInfo;
      try{
      users.displayName = v.data()?['name'];
      // users.displayName = k.displayName;
      users.image = v.data()?['images'];
      users.id = v.data()?['id'];
      // users.id = k.id;
      // print(users.id);
      users.spotifyBasedGenre = v.data()?['spotifyGenre'];
      // print(v.data());
      return users;
      }catch(e){
        print("User id doesn't exist in users collection on firebase");
      }
    });
    return users;
  }

  Future<List<UserInfo>?> fetchRecommendedUsersInfo(numberOfUsers) async {
    List<dynamic>? likeUsersId = []; // In firebase type is dynamic
    List<UserInfo>? likeUsersInfo = [];
    StoreUserInfo _storeUserInfo = StoreUserInfo();
    if(StaticStore.currentUserGenreId=="" || StaticStore.currentUserGenreId==null){
      await _storeUserInfo.fetch_store_user_info();
      print("Fetched user info again, because it was null");
    }
    // UserInfo? currentUser = await _storeUserInfo.fetchCurrentUserInfo();
    // print(currentUser?.spotifyBasedGenre);
    // print(StaticStore.userGenre);

    // return null;
    await FirebaseFirestore.instance
        .collection('spotifyBasedGenreUsers')
        .get()
        .then((value) async {
      likeUsersId = value.docs[0]['genreList'][StaticStore.currentUserGenreId];
      // print(StaticStore.);
      // print(value.docs[0]['genreList'][StaticStore.currentUserGenreId]);
      // return null;



      likeUsersId?.remove(StaticStore.currentUserId);
      for (int i = 0; likeUsersId != null && i < likeUsersId!.length && i<numberOfUsers; i++) {
        likeUsersInfo.add(await fetchUserInfo(likeUsersId?[i]));
      }
      return likeUsersInfo;
    });

    return likeUsersInfo;
  }

  Future<List<UserInfo>?> fetchAllUsersInfo(numberOfUsers) async {
    List<dynamic>? allUsersId = []; // In firebase type is dynamic
    List<UserInfo>? allUsersInfo = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      // try{
        for(int i=0;i<value.docs.length;i++){
          allUsersId.add(value.docs[i].id);
        }
        if(allUsersId.length>2){
          allUsersId.remove(StaticStore.currentUserId);
        }
        for (int i = 0;i < allUsersId.length && i < numberOfUsers;i++) {
          allUsersInfo.add(await fetchUserInfo(allUsersId[i]));
        }
        return allUsersInfo;
      // }catch(e){
        // print("Error happened while callling for the alluserInfo");
        // return allUsersInfo;
      // }
    });

    return allUsersInfo;
  }

  Future<int> getNumberOfUsers() async {
    var a = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      a = value.docs.length;
    });
    return a;
  }
}
