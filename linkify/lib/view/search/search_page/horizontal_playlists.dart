import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/controller/playlist/playlist_track.dart';
import 'package:linkify/controller/home/front_page_data/recommendations.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/model/playlists/playlist.dart';
import 'package:linkify/view/album/album_view.dart';
import 'package:linkify/view/home/loading.dart';
// import 'package:linkify/widgets/uis/utils/loading.dart';
// import '../controllers/main_controller.dart';
// import '../models/song_model.dart';
// import '../models/user.dart';
// import '../screens/artist_profile/artist_profile.dart';
// import 'loading.dart';

// import 'botttom_sheet_widget.dart';

class HorizontalPlaylist extends StatelessWidget {
  // final List<SongModel> songs;
  // final MainController con;
  List<MyPlaylist>? _playlist;
  int start=0;

  HorizontalPlaylist(this._playlist,this.start);
  // HorizontalPlaylist();

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    // print(_playlist??[0].imgUrl);

    return SizedBox(
      height: 210,
      // height: 230,
      child: _playlist!=null?ListView.builder(
          scrollDirection: Axis.horizontal,
          // itemCount: songs.length,
          itemCount: _playlist!.length-start,
          itemBuilder: (context, i) {
            // final song = songs[i];
            return InkWell(
              onTap: () async {
                print("list album clicked");
                List<AlbumTrack>? _albumTracks = await fetchPlaylistTracks(_playlist?[i+start].id);

                /* Stored queue for front page categories */
                // StaticStore.myQueueTrack = _albumTracks!;
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlbumView(_playlist?[i+start].imgUrl, _playlist?[i+start].name, _albumTracks)));
                
                
                
                // print(_playlist?[i]);
                
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
                          imageUrl: "${_playlist?[i+start].imgUrl}",
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
                        "${_playlist?[i+start].name}",
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
          }):Center(child:Text("No playlists available")),
    );
  }
}