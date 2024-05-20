import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/sticky_widgets.dart';
import 'package:linkify/widgets/uis/models/loading_enum.dart';
import 'package:linkify/widgets/uis/screens/home/home_screen.dart';
import 'package:linkify/widgets/uis/screens/library/library.dart';
import 'package:linkify/widgets/uis/screens/search/cubit/search_cubit.dart';
import 'package:linkify/widgets/uis/utils/bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import '../../controllers/main_controller.dart';
import '../../methods/string_methods.dart';
import '../../models/genreTag.dart';
import '../genre_page/genre_page.dart';
import '../search_results/search_result.dart';

class SearchPage extends StatelessWidget {
  // final MainController con;

  const SearchPage({
    Key? key,
    // required this.con,
  }) : super(key: key);

  // List<PersistentBottomNavBarItem> _navBarsItems(var context) {
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
  //         onPressed: (_) {
  //           print("hello");
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

  // Widget footer(var context){
  //   return Container(
  //     padding: EdgeInsets.only(left:20,right:20),
  //               color:Colors.black,
  //               child:
  //             Row(children: [
  //                 IconButton(icon:const Icon(LineIcons.home,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => HomeScreen(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //                 Spacer(),
  //                 IconButton(icon:const Icon(CupertinoIcons.search,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => SearchPage(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //                 Spacer(),
  //                 IconButton(icon:const Icon(CupertinoIcons.music_albums,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => Library(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //             ])
  //             );
  // }

  @override
  Widget build(BuildContext context) {
    final allTags = tags.map((e) => TagsModel.fromJson(e)).toList();
    print("Searchpage");
    return BlocProvider(
        create: (context) => SearchCubit()..getGenre(),
        // create:(_){},
        child: BlocBuilder<SearchCubit, SearchState>(
            // child: BlocBuilder(
            builder: (context, state) {
          if (state.status == LoadPage.loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SafeArea(
                      child: 
                      // Stack(
                      //   alignment: Alignment.bottomCenter,
                      //   children: [
                          NestedScrollView(
                            headerSliverBuilder:
                                (BuildContext context, bool innerBoxIsScrolled) {
                              return [
                                const SliverToBoxAdapter(
                                    child: SizedBox(
                                  height: 40,
                                )),
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      "Search",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            fontSize: 36,
                                          ),
                                    ),
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                    child: SizedBox(
                                  height: 5,
                                )),
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate: SliverSearchAppBar(),
                                ),
                  
                                // SliverPersistentHeader(
                                //   pinned: true,
                                //   delegate: SliverSearchAppBar(),
                                // ),
                              ];
                            },
                            body: ListView(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18.0),
                                  child: Text(
                                    "Your Top genre",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                                GridView.builder(
                                  // itemCount: allTags.sublist(0, 4).length,
                                  // itemCount: StaticStore.userGenre[0].length,
                                  itemCount: 4,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14,
                                    crossAxisSpacing: 14,
                                    childAspectRatio: 16 / 8,
                                  ),
                                  itemBuilder: (context, i) {
                                    return TagWidget(
                                        tag: allTags.sublist(0, 4)[i],
                                        genreName: StaticStore.userGenre![i]
                                        // genreName: "$i"
                                        // StaticStore.userGenre[i]
                                        );
                                    // return SizedBox();
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24.0),
                                  child: Text(
                                    "Browse all",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                                GridView.builder(
                                  itemCount: allTags.sublist(4).length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14,
                                    crossAxisSpacing: 14,
                                    childAspectRatio: 16 / 8,
                                  ),
                                  itemBuilder: (context, i) {
                                    return TagWidget(
                                        tag: allTags.sublist(4)[i],
                                        genreName: tags[i]
                                            .entries
                                            .elementAt(0)
                                            .value
                                            .toString());
                                    // return SizedBox();
                                  },
                                ),
                                const SizedBox(height: 100),
                                
                              ],
                            ),
                          ),
                    ),
                  ),
                        StreamBuilder(
                          stream: StaticStore.player.playerStateStream,
                          builder: (context, snapshot1) {
                            return StaticStore.playing == true || StaticStore.pause==true?
                            miniplayer(context)
                            : const SizedBox();
                          }
                        ),
                      // )
                      footer(context),
                ],
              ),
            );
          }
        }));
  }
}

class TagWidget extends StatelessWidget {
  final TagsModel tag;
  String genreName;
  // final MainController con;
  TagWidget({
    Key? key,
    required this.tag,
    required this.genreName,

    // required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => SizedBox()
                // GenrePage(
                // tag: tag,
                // con: con,
                // )
                ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: tag.color,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade900,
                    offset: const Offset(1, 1),
                    spreadRadius: 1,
                    blurRadius: 50,
                    blurStyle: BlurStyle.outer),
              ]),
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 5,
                right: -15,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(385 / 360),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: tag.color,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: kElevationToShadow[2],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        imageUrl: tag.image,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        maxHeightDiskCache: 120,
                        maxWidthDiskCache: 120,
                        memCacheHeight:
                            (120 * MediaQuery.of(context).devicePixelRatio)
                                .round(),
                        memCacheWidth:
                            (120 * MediaQuery.of(context).devicePixelRatio)
                                .round(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child:
                    // genreName==""?const Text("hello"):
                    Text(genreName),

                // Text(tag.tag.toTitleCase(),style: TextStyle(color:Colors.white,fontWeight: FontWeight.w900),),
                // Theme.of(context)
                //     .textTheme
                //     .bodyText1!
                //     .copyWith(fontSize: 20, fontWeight: FontWeight.bold)
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    SearchResultsPage( 
                        // con: con,
                        )));
      },
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const SizedBox(
                      height: 50, child: Icon(CupertinoIcons.search)),
                  const SizedBox(width: 10),
                  Text(
                    "Songs, Artists or Genres",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade800,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
