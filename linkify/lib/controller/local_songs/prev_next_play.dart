import 'package:linkify/controller/local_songs/songPlayerController.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> play_next_local(List<SongModel>songList)async{
  SongPlayerController _songPlayerController = SongPlayerController();
  StaticStore.songIndex++;
        if(StaticStore.songIndex>=songList.length){
          StaticStore.songIndex = StaticStore.songIndex%songList.length;
        }
          await _songPlayerController.stopLocalSong().then((value) async {
            // if(StaticStore.queueIndex>=StaticStore.myQueueTrack.length){
            //   StaticStore.queueIndex--;
            //   return;
            // }

            await _songPlayerController.playLocalSong(
                    songList[StaticStore.songIndex].data,songList[StaticStore.songIndex].artist,songList[StaticStore.songIndex].displayName
                    );
            //     .then((value) {
            //   StaticStore.currentSong =
            //       songList[StaticStore.songIndex].displayName;
            //   StaticStore.currentArtists =
            //       [songList[StaticStore.songIndex].artist];
            //   StaticStore.currentSongImg =
            //       "";
            //   StaticStore.playing = true;
            //   StaticStore.pause = false;
            // });
          });
}



Future<void> play_prev_local(List<SongModel>songList)async{
  SongPlayerController _songPlayerController = SongPlayerController();
  StaticStore.songIndex--;
        if(StaticStore.songIndex<0){
          StaticStore.songIndex = songList.length-1;
        }
          await _songPlayerController.stopLocalSong().then((value) async {
            // if(StaticStore.queueIndex>=StaticStore.myQueueTrack.length){
            //   StaticStore.queueIndex--;
            //   return;
            // }

            await _songPlayerController.playLocalSong(
                    songList[StaticStore.songIndex].data,songList[StaticStore.songIndex].artist,songList[StaticStore.songIndex].displayName
                    );
            //     .then((value) {
            //   StaticStore.currentSong =
            //       songList[StaticStore.songIndex].displayName;
            //   StaticStore.currentArtists =
            //       [songList[StaticStore.songIndex].artist];
            //   StaticStore.currentSongImg =
            //       "";
            //   StaticStore.playing = true;
            //   StaticStore.pause = false;
            // });
          });
}