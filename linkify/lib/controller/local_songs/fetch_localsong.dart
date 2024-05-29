
/* Readin file */
  // import 'package:linkify/widgets/uis/models/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<List<SongModel>> read() async {
  final audioQuery = OnAudioQuery();
    List<SongModel> localSongs = await audioQuery.querySongs(
      ignoreCase: false,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
      // uriType: UriType.INTERNAL,
    );
    
    // print("localSongs: ${localSongs[0].displayName}");
    return localSongs;
}