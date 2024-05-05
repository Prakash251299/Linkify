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
import 'package:linkify/controller/logout.dart';
import 'package:linkify/controller/recommendations.dart';
import 'package:linkify/controller/user_genre.dart';
import 'package:linkify/controller/play_spotify_song.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/album.dart';
import 'package:linkify/widgets/carousel_view.dart';
import 'package:marquee/marquee.dart';
import 'uis/controllers/main_controller.dart';
import '../controller/get_greeting.dart';

import 'uis/models/user.dart';
import 'uis/screens/artist_profile/artist_profile.dart';
import 'uis/utils/loading.dart';

class CarouselSongs extends StatefulWidget {
  // var m = {};
  Map<String, List<dynamic>>? m = {};

  CarouselSongs(this.m, {super.key});

  @override
  State<CarouselSongs> createState() => _CarouselSongsState();
}

class _CarouselSongsState extends State<CarouselSongs> {

  PlaySpotifySong _playSpotifySong = PlaySpotifySong();

  Future<void> fetchAlbumSongs(var albumId, int ind) async {
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
    String? id = "";
    String? name = "";

    // DateTime now = DateTime.now(); // 30/09/2021 15:54:30
    // var dateToday = now.day.toString();
    // dateToday += "-";
    // dateToday += now.month.toString();
    // dateToday += "-";
    // dateToday += now.year.toString();
    // if (StaticStore.dateStored == dateToday &&
    //     StaticStore.m1[ind]['name'] != null) {
    //   return;
    // }
    // StaticStore.dateStored = dateToday;

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
        var a = await e.handleError(res);
        if(a==2){
          print("null refresh token plaese go to login or restart the app");
          return;
        }
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
        var a = await e.handleError(res);
        if(a==2){
          print("null refresh token plaese go to login or restart the app");
        }
      }
    }
  }

  // var _useRtlText = false;

  @override
  Widget build(BuildContext context) {
    var devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return 
    
    SafeArea(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            // filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: 
                // widget.m?['trackName']!=null
                // widget.m?.length!=0
                widget.m!['name']!.length!=0
                //  && widget.m?['trackName']?[0]!=""
                ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column(
                //   children: [
                    Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Wrap(
                        // alignment: WrapAlignment.center,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 8,
                        spacing: 8,
                        children: [
                          for (int i = 0; i < widget.m!['name']!.length && i < 6;i++) ...{
                            InkWell(
                              onTap: () async {
                                print("Inside carousel");
                                // await fetchUserGenre();
                          
                                setState(() {
                                  StaticStore.carouselInd = i;
                                });
                          
                                await fetchAlbumSongs(widget.m?['id']?[i], i);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CarouselView(
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
                                  // color: Colors.black,
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
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          }
                        
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                //   ],
                // ):SizedBox(),
              ],
            ):
            // Text("sagd",style:TextStyle(color: Colors.white)),
            SizedBox(),
          ),
        ],
      ),
    );
  }
}
