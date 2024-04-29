import 'dart:convert';
import 'dart:ui';

// import 'package:b/models/category.dart';

// import 'package:flutter/material.dart' as importedIcon;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/recommendations.dart';
import 'package:linkify/controller/user_genre.dart';
import 'package:linkify/controller/play_spotify_song.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/album.dart';
import 'package:linkify/widgets/album_view.dart';
import 'package:marquee/marquee.dart';
import 'uis/controllers/main_controller.dart';
import 'uis/methods/get_greeting.dart';

import 'uis/models/user.dart';
import 'uis/screens/artist_profile/artist_profile.dart';
import 'uis/utils/loading.dart';

class CarouselSongs extends StatefulWidget {
  // var m = {};
  Map<String, List<dynamic>>? m = {};

  CarouselSongs(this.m, {super.key});

  @override
  State<CarouselSongs> createState() => _RecentUsersState();
}

class _RecentUsersState extends State<CarouselSongs> {

  PlaySpotifySong _playSpotifySong = PlaySpotifySong();

  Future<void> fetchAlbumSongs(var albumId, int ind) async {
    String? id = "";
    String? name = "";

    DateTime now = DateTime.now(); // 30/09/2021 15:54:30
    var dateToday = now.day.toString();
    dateToday += "-";
    dateToday += now.month.toString();
    dateToday += "-";
    dateToday += now.year.toString();
    if (StaticStore.dateStored == dateToday &&
        StaticStore.m1[ind]['name'] != null) {
      return;
    }
    StaticStore.dateStored = dateToday;

    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();
      // print("Hhhhh");

      /* Fetching album tracks */
      var res = await get(Uri.parse(
          'https://api.spotify.com/v1/albums/$albumId/tracks?offset=0&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&time_range=short_term&access_token=$accessToken'));
      // var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        id = data['items'][0]['id'];
        name = data['items'][0]['name'];

        await fetchSimilarTracks(id, ind);
        // print("$name $id");

        return;
      } else {
        AccessError e = AccessError();
        await e.handleError(res);
      }
    }
  }
  Future<void> fetchSimilarTracks(var songId, var ind) async {
    List<String>? name = [];
    List<String>? id = [];
    List<String>? trackArtists = [];
    List<String>?trackImg = [];
    List<List<String>>? artistNames = [];
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();

      /* Fetching album tracks */
      var res = await get(Uri.parse(
          'https://api.spotify.com/v1/recommendations?seed_tracks=$songId&limit=50&access_token=$accessToken'));
      // var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for (int i = 0; i < 50; i++) {
          // fetching 50 similar songs
          name.add(data['tracks'][i]['name']);
          id.add(data['tracks'][i]['id']);
          trackImg.add(data['tracks'][i]['album']['images'][0]['url']);

          for(int j=0;j<data['tracks'][i]['artists'].length;j++){
            trackArtists?.add(data['tracks'][i]['artists'][j]['name']);
          }
          artistNames.add(trackArtists!);
          trackArtists=[];
          // imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
        }
        // print(artistNames);
        // print(imgUrl);
        // DateTime now = DateTime.now(); // 30/09/2021 15:54:30
        // var dateToday = now.day.toString();
        // dateToday += "-";
        // dateToday += now.month.toString();
        // dateToday += "-";
        // dateToday += now.year.toString();
        // if (StaticStore.dateStored != dateToday || StaticStore.m1[ind] == {}) {
        //   print(dateToday);
        StaticStore.m1[ind].addEntries({'id': id}.entries);
        StaticStore.m1[ind].addEntries({'name': name}.entries);
        StaticStore.m1[ind].addEntries({'artists': artistNames}.entries);
        StaticStore.m1[ind].addEntries({'trackImg': trackImg}.entries);
        // StaticStore.dateStored = dateToday;
        // StaticStore.carouselInd = ind;
        // m1.addEntries({'date':dateOnly}.entries);
        // }
        // return;
        // print();
        // m.addEntries({'image':imgUrl}.entries);
        // print(m1['name']);
        return;
      } else {
        AccessError e = AccessError();
        await e.handleError(res);
      }
    }
  }

  // var _useRtlText = false;

  @override
  Widget build(BuildContext context) {
    var devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    var greet = greeting();
    // print(widget.m);
    // print(widget.m?['image']);
    // s = getCategories();
    return 
    
    SafeArea(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: 
                  Row(
                    children: [
                      Text(
                        greet,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                IconButton(
                  onPressed: () async {
                    print('more vert icon clicked');
                    await carouselRecommendation('');
                  },
                  icon: Icon(Icons.more_vert,color: Colors.white,),
                ),
                    ],
                  ),
                ),
      
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      for (int i = 0;i < widget.m!['name']!.length && i < 6;i++) ...{
                        // for (int i = 0; i<6; i++) ...{
                        //   print('ljkjk'),
                        InkWell(
                          onTap: () async {
                            print("Here");
                            // await fetchUserGenre();
      
                            setState(() {
                              StaticStore.carouselInd = i;
                            });
      
                            await fetchAlbumSongs(widget.m?['id']?[i], i);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AlbumView(
                                    widget.m?['image']?[i],
                                    StaticStore.m1[i]['name'],
                                    widget.m?['trackName']?[i],
                                    StaticStore.m1[i]['id'],
                                    StaticStore.m1[i]['artists'],
                                    StaticStore.m1[i]['trackImg']
                                    // widget.m?['artists']?[i],
                                    
                                )));
      
                            // });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            width:
                                ((MediaQuery.of(context).size.width * .5) - 21.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3),
                                  ),
                                  child: CachedNetworkImage(
                                    // imageUrl: user.avatar!,
                                    imageUrl: widget.m?['image']?[i] ?? "",
                                    // imageUrl: "",
      
                                    width: 55,
                                    height: 55,
                                    memCacheHeight:
                                        (55 * devicePexelRatio).round(),
                                    memCacheWidth:
                                        (55 * devicePexelRatio).round(),
                                    maxHeightDiskCache:
                                        (55 * devicePexelRatio).round(),
                                    maxWidthDiskCache:
                                        (55 * devicePexelRatio).round(),
                                    progressIndicatorBuilder: (context, url, l) =>
                                        const LoadingImage(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      // width:auto,
                                      child:
                                          // Text("jejk"),
                                          // Text("${widget.m?['name']?[i]}"),
      
                                          // Text("hello",style:TextStyle(color:Colors.white)),
                                          Marquee(
                                        text: '${widget.m?['trackName']?[i]}   ',
                                        // text: 'hi   ',
      
                                        style: TextStyle(color: Colors.white),
                                        velocity: 4,
                                      ),
      
                                      //     Marquee(
                                      //   key: Key("$_useRtlText"),
                                      //   text: "${widget.m?['name']?[i]}",
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold),
                                      //   scrollAxis: Axis.horizontal,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   blankSpace: 20,
                                      //   velocity: 10,
                                      //   // pauseAfterRound: Duration(seconds: 1),
                                      //   showFadingOnlyWhenScrolling: true,
                                      //   fadingEdgeStartFraction: 0.1,
                                      //   fadingEdgeEndFraction: 0.1,
                                      //   // numberOfRounds: 3,
                                      //   startPadding: 10,
                                      //   // accelerationDuration: Duration(seconds: 1),
                                      //   // accelerationCurve: Curves.linear,
                                      //   // decelerationDuration: Duration(milliseconds: 500),
                                      //   // decelerationCurve: Curves.easeOut,
                                      //   // textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
                                      //   textDirection: TextDirection.ltr,
                                      // )
                                    ),
                                    // Text(
                                    //   // user.name!,
                                    //   widget.m['name'][i],
                                    //   style:TextStyle(color: Colors.white),
                                    //   // style: Theme.of(context)
                                    //       // .textTheme
                                    //       // .bodyText1,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // )
                        //     .toList(),
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}