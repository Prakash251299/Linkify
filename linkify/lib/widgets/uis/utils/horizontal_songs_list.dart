import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/first_page_categories.dart';
import 'package:linkify/controller/playlist_track.dart';
import 'package:linkify/controller/recommendations.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/widgets/album_view.dart';
import 'package:linkify/widgets/carousel_view.dart';
import '../controllers/main_controller.dart';
import '../models/song_model.dart';
import '../models/user.dart';
import '../screens/artist_profile/artist_profile.dart';
import 'loading.dart';

import 'botttom_sheet_widget.dart';

class HorizontalSongList extends StatelessWidget {
  // final List<SongModel> songs;
  // final MainController con;
  FrontPageCategories? _categories;
  HorizontalSongList(this._categories);
  // HorizontalSongList();

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    // print(_categories?.playlists?[0].imgUrl);

    return SizedBox(
      height: 210,
      // height: 230,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // itemCount: songs.length,
          itemCount: _categories?.playlists.length,
          itemBuilder: (context, i) {
            // final song = songs[i];
            return InkWell(
              onTap: () async {
                print("list album clicked");
                List<AlbumTrack>? _albumTracks = await fetchPlaylistTracks(_categories?.playlists[i].id);

                /* Stored queue for front page categories */
                // StaticStore.myQueueTrack = _albumTracks!;
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlbumView(_categories?.playlists[i].imgUrl, _categories?.playlists[i].name, _albumTracks)));
                
                
                
                // print(_categories?.playlists[i]);
                
                // con.playSong(con.convertToAudio(songs), songs.indexOf(song));
              },
              onLongPress: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    isScrollControlled: true,
                    elevation: 100,
                    backgroundColor: Colors.black38,
                    context: context,
                    builder: (context) {
                      return 
                      SizedBox();
                      // BottomSheetWidget(
                        // con: con, song: song
                      // );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: 
                        
                        CachedNetworkImage(
                          // imageUrl: song.coverImageUrl!,
                          imageUrl: "${_categories?.playlists[i].imgUrl}",
                          // imageUrl: "",
                          // imageUrl: "https://daily-mix.scdn.co/covers/time-capsule/time-capsule-blue_DEFAULT-en-GB.jpg",
                          width: 150,
                          height: 150,
                          maxHeightDiskCache: (200 * devicePexelRatio).round(),
                          maxWidthDiskCache: (200 * devicePexelRatio).round(),
                          memCacheHeight: (200 * devicePexelRatio).round(),
                          memCacheWidth: (200 * devicePexelRatio).round(),
                          progressIndicatorBuilder: (context, url, l) =>
                              const LoadingImage(size: 80),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        // song.songname!,
                        "${_categories?.playlists[i].name}",
                        // "${_categories?.name}",
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            !.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class HorizontalArtistList extends StatelessWidget {
  // final List<User> users;
  // final MainController con;
  const HorizontalArtistList({
    Key? key,
    // required this.users,
    // required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return SizedBox(
      height: 210,
      child: ListView.builder(
          // itemCount: users.length,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            // final user = users[i];
            return InkWell(
              onTap: (){},
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       CupertinoPageRoute(
              //           builder: (context) =>
              //               ArtistProfile(username: user.username!, con: con)));
              // },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          // imageUrl: user.avatar!,
                          imageUrl: "",
                          width: 150,
                          height: 150,
                          maxHeightDiskCache: (200 * devicePexelRatio).round(),
                          maxWidthDiskCache: (200 * devicePexelRatio).round(),
                          memCacheHeight: (200 * devicePexelRatio).round(),
                          memCacheWidth: (200 * devicePexelRatio).round(),
                          progressIndicatorBuilder: (context, url, l) =>
                              const LoadingImage(
                            size: 80,
                            icon: Icon(
                              LineIcons.user,
                              size: 80,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        // user.name!,
                        "",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
