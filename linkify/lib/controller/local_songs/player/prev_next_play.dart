import 'package:linkify/controller/local_songs/player/songPlayerController.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> play_next_local(List<SongModel> songList) async {
  SongPlayerController _songPlayerController = SongPlayerController();
  StaticStore.songIndex++;
  if (StaticStore.songIndex >= songList.length) {
    StaticStore.songIndex = StaticStore.songIndex % songList.length;
  }
  await _songPlayerController.stopLocalSong().then((value) async {
    await _songPlayerController.playLocalSong(
        songList[StaticStore.songIndex].data,
        songList[StaticStore.songIndex].artist,
        songList[StaticStore.songIndex].displayName);
  });
}

Future<void> play_prev_local(List<SongModel> songList) async {
  SongPlayerController _songPlayerController = SongPlayerController();
  StaticStore.songIndex--;
  if (StaticStore.songIndex < 0) {
    StaticStore.songIndex = songList.length - 1;
  }
  await _songPlayerController.stopLocalSong().then((value) async {
    await _songPlayerController.playLocalSong(
        songList[StaticStore.songIndex].data,
        songList[StaticStore.songIndex].artist,
        songList[StaticStore.songIndex].displayName);
  });
}
