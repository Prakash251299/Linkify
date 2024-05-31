import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/controller/home/get_greeting.dart';
import 'package:linkify/controller/home/logout.dart';
import 'package:linkify/controller/notification/notification_functions.dart';
import '../../controller/variables/loading_enum.dart';
import 'horizontal_songs_list.dart';
import '../carousel/carousel_songs.dart';
import 'cubit/home_cubit.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/view/Network/request_notification_screen.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int numberOfFrontPageCategories = 5;

class _HomeScreenState extends State<HomeScreen> {
  double menuWidth = 0;

  @override
  void initState() {
    StaticStore.screen = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var optionColor = Color.fromARGB(255, 50, 76, 79);
    return GestureDetector(
      onTap: () {
        print("tapped");
        setState(() {
          menuWidth = 0;
        });
      },
      child: BlocProvider(
          create: (context) => HomeCubit()..getAlbums(),
          child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            print("homescreen");
            if (state.status == LoadPage.loading) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Loading front page data"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If it is taking too long check your internet",
                            maxLines: 3,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            if (state.status == LoadPage.loaded) {
              var greet = greeting();
              return SafeArea(
                child: Scaffold(
                  body: Column(children: [
                    Stack(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        child: Container(
                          // color: Colors.red,
                          // padding:EdgeInsets.only(bottom: 10),
                          height: 60,
                          child: Row(
                            children: [
                              Text(
                                greet,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  StreamBuilder(
                                      stream: FetchRequestNotifications()
                                          .asStream(),
                                      builder: (context, snapshot) {
                                        // print(snapshot.data!.length);
                                        if (snapshot.data != null &&
                                            snapshot.data!.length >
                                                StaticStore
                                                    .notificationCounts) {
                                          return IconButton(
                                              onPressed: () async {
                                                setState(() {});
                                                StaticStore.notificationCounts =
                                                    snapshot.data != null
                                                        ? snapshot.data!.length
                                                        : 0;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RequestNotificationScreen()));
                                              },
                                              icon: Icon(
                                                Icons.notifications_active,
                                                color: Colors.red,
                                              ));
                                        }
                                        return IconButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RequestNotificationScreen()));
                                            },
                                            icon: Icon(
                                              Icons.notifications,
                                              color: Colors.white,
                                            ));
                                      }),
                                  IconButton(
                                    onPressed: () async {
                                      print('Sign out called');
                                      if (menuWidth == 0) {
                                        setState(() {
                                          menuWidth = 200;
                                        });
                                      } else {
                                        setState(() {
                                          menuWidth = 0;
                                        });
                                      }
                                    },
                                    icon: menuWidth == 200
                                        ? Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ), // more_vert _icon
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // //////////////////////////////
                      // menu==0?
                      // AnimatedContainer (
                      //   duration: Duration (seconds: 3),
                      //   width: 200,
                      //   height: 400,
                      //   color: Colors.red,
                      // ):SizedBox(),
                      // //////////////////////////////
                    ]),

                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          // padding:EdgeInsets.only(bottom: 50),
                          height: MediaQuery.of(context).size.height - 88,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CarouselSongs(state.carouselSongs),
                                // Spacer(),

                                for (int k = 0;
                                    k < numberOfFrontPageCategories;
                                    k++) ...{
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0,
                                      vertical: 8,
                                    ),
                                    // EdgeInsets.only(top:16,left:7),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${state.categories?[k].name}",
                                          // style: TextStyle(color:Colors.white),
                                          // TextStyle(color: Colors.red),TextTheme(titleMedium: )
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  HorizontalSongList(state.categories?[k]),
                                  const SizedBox(height: 12),
                                },
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // StaticStore.player.processingState==ProcessingState.completed?

                        StreamBuilder(
                            stream: StaticStore.player.playerStateStream,
                            builder: (context, snapshot1) {
                              return StaticStore.playing == true ||
                                      StaticStore.pause == true
                                  ?
                                  // Text("hi")
                                  miniplayer(context)
                                  : const SizedBox();
                            }),

                        //////////////////////////////
                        // menu==1?
                        Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height -
                                  88 -
                                  400),
                          // margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height-128),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: menuWidth,
                                  height: 400,
                                  // color: Colors.black,
                                  child: Column(
                                    // alignment: Alignment.topRight,
                                    children: [
                                      menuWidth == 200
                                          ? Center(
                                              child: InkWell(
                                                child: Container(
                                                    height: 40,
                                                    // width:menuWidth==200?menuWidth:200,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: optionColor,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))),
                                                onTap: () async {
                                                  await callSignOutApi(context);
                                                },
                                              ),
                                            )
                                          : SizedBox(),
                                      // ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      menuWidth == 200
                                          ? Center(
                                              child: InkWell(
                                                child: Container(
                                                  height: 40,
                                                  // width:menuWidth==200?menuWidth:200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: optionColor,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "Issues",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                                onTap: () async {
                                                  await launchUrl(Uri.parse(
                                                      'https://github.com/Prakash251299/Linkify/issues'));
                                                },
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  )),
                            ],
                          ),
                        )
                        // :SizedBox()
                        //////////////////////////////
                        ,

                        footer(context),
                      ],
                    ),
                    // ),
                  ]),
                ),
              );
            }
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            callSignOutApi(context);
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No data found",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            );
          })),
    );
  }
}
