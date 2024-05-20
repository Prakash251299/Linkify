// import 'package:b/utils/bottom_nav_bar/models/nav-bar-padding.model.dart';
// import 'package:b/utils/bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
// import 'package:b/utils/bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
// import 'package:b/utils/bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/user_genre.dart';
// import 'package:linkify/model/carousel.dart';
import 'package:linkify/model/liked_songs.dart';
import 'package:linkify/widgets/uis/api/url.dart';
import 'package:linkify/widgets/uis/repositories/get_search_results.dart';
import 'package:linkify/widgets/uis/utils/bottom_nav_bar/models/nav-bar-padding.model.dart';
import 'package:linkify/widgets/uis/utils/bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:linkify/widgets/uis/utils/bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:linkify/widgets/uis/utils/bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
// import 'package:spotify_clone/utils/bottom_nav_bar/persistent-tab-view.dart';
import '../../controllers/main_controller.dart';
import '../../utils/bottom_nav_bar/persistent-tab-view.widget.dart';
import '../current_playing/current_player.dart';
import '../current_playing/current_playing_song.dart';
import '../library/library.dart';
import '../search_page/search_page.dart';

import '../../utils/bottom_play_widget.dart';
import '../home/home_screen.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  SearchRepository _searchRepository = SearchRepository();
  @override
  void initState() {
    print(StaticStore.userGenre);
    super.initState();
  }

  // List<IconButton> _navBarsItems1(){
  //   return [
  //     IconButton(
  //       onPressed: (){}, 
  //       icon: const Icon(Icons.home)
  //     ),
  //     IconButton(
  //       onPressed: (){}, 
  //       icon: const Icon(Icons.search)
  //     ),
  //     IconButton(
  //       onPressed: (){}, 
  //       icon: const Icon(Icons.library_music)
  //     )
  //   ];
  // }

  // List<routeAndNavigatorSettings> _navBarsItems() {

  // }
  
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
      
  //     PersistentBottomNavBarItem(
  //         // inactiveIcon: IconButton(icon:const Icon(LineIcons.home),onPressed: (){
  //         //   Navigator.of(context).push(
  //         //   MaterialPageRoute(
  //         //       builder: (_) => HomeScreen(),
  //         //       )).then((value) => Navigator.pop(context));
  //         // },),
  //         icon: const Icon(Icons.home),
  //         inactiveIcon: const Icon(LineIcons.home),
  //         activeColorSecondary: Colors.white,
  //         activeColorPrimary: Colors.grey),
  //     PersistentBottomNavBarItem(
  //         // inactiveIcon: IconButton(icon:const Icon(LineIcons.search),onPressed: (){
  //         //   Navigator.of(context).push(
  //         //   MaterialPageRoute(
  //         //       builder: (_) => 
  //         //       SearchPage()
  //         //       // AppStateManager.persistentTabController.jumpToTab(0);
  //         //       ));
  //         // },),
  //         // routeAndNavigatorSettings = const RouteAndNavigatorSettings(),
  //         onPressed: (_){
  //           PersistentTabController p = PersistentTabController();
  //           print("hello");
  //           // p.jumpToTab(1);
  //           Navigator.of(context).pushAndRemoveUntil(
  //             CupertinoPageRoute(
  //               builder: (BuildContext context) {
  //                 return SearchPage();
  //               },
  //             ),
  //             (_) => false,
  //           );
  //         },
  //         icon: const Icon(CupertinoIcons.search),
  //         inactiveIcon: const Icon(CupertinoIcons.search),
  //         activeColorSecondary: Colors.white,
  //         activeColorPrimary: Colors.grey),
  //     PersistentBottomNavBarItem(
  //         // inactiveIcon: IconButton(icon:const Icon(CupertinoIcons.music_albums),onPressed: (){
  //         //   Navigator.of(context).push(
  //         //   MaterialPageRoute(
  //         //       builder: (_) => Library(),
  //         //       )).then((value) => Navigator.pop(context));
  //         // },),
  //         icon: const Icon(CupertinoIcons.music_albums),
  //         inactiveIcon: const Icon(CupertinoIcons.music_albums),
  //         activeColorSecondary: Colors.white,
  //         activeColorPrimary: Colors.grey),
  //   ];
  // }

  // List<Widget> _buildScreens() {
  //   return [HomeScreen(), const SearchPage()];
  // }

  // CallApi _callApi = CallApi();
  @override
  Widget build(BuildContext context) {
    return 
    HomeScreen();
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children:[ 
    //   FloatingActionButton(
    //     onPressed: (){
    //       _callApi.getData();
    //     }
    //   ),
    //   // Spacer(),
    //   FloatingActionButton(
    //     backgroundColor: Colors.red,
    //     onPressed: (){
    //       LikedTracks l = LikedTracks();
    //       print(LikedTracks.id);
    //       // LikedTracks.fromJson();
    //     },
    //     hoverElevation: 5,
    //   )
    // ]);






    // ChangeNotifierProvider(
    //     create: (context) => MainController()..init(),
    //     // create: (context) => MainController()..myfun(),
    //     child: Consumer<MainController>(builder: (context,con, child) {
          
    //       return PersistentTabView(
    //         context,
    //         controller: controller,
            
    //         playWidget: 
    //         Material(
    //           child: 
    //           SizedBox(),
    //           // PlayWidget(
    //           //     con: con,
    //           //     onTap: () {
    //           //       print("li");
    //           //       // showModalBottomSheet(
    //           //       //   context: context,
    //           //       //   isScrollControlled: true,
    //           //       //   isDismissible: false,
    //           //       //   builder: (context) => 
    //           //       //   SizedBox(),
    //           //       //   // CurrentPlayingSong(
    //           //       //     // con: con,
    //           //       //   // ),
    //           //       // );
    //           //       // Navigator.push(
    //           //       //     context,
    //           //       //     CupertinoPageRoute(
    //           //       //       builder: (context) => CurrentPlayer(
    //           //       //         con: con,
    //           //       //       ),
    //           //       // ));
    //           //     }),
    //         ),
    //         screens: _buildScreens(),
    //         items: _navBarsItems(),
    //         confineInSafeArea: true,
    //         backgroundColor: Colors.black,
    //         handleAndroidBackButtonPress: true,
    //         hideNavigationBarWhenKeyboardShows: true,
    //         resizeToAvoidBottomInset: true,
    //         popAllScreensOnTapOfSelectedTab: true,
    //         popActionScreens: PopActionScreensType.all,
    //         navBarStyle: NavBarStyle.simple,
    //         navBarHeight: 55,
    //         padding: const NavBarPadding.all(0),

    //         // handleAndroidBackButtonPress: true,
    //         // hideNavigationBarWhenKeyboardShows: true,
    //         // // resizeToAvoidBottomInset: false,
    //         // popAllScreensOnTapOfSelectedTab: false,
    //         // popActionScreens: PopActionScreensType.values[0],
    //         // navBarStyle: NavBarStyle.simple,




    //       );
    //     }));
  }
}
