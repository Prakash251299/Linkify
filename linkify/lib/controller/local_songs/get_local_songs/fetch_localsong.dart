
/* Readin file */
  // import 'package:linkify/widgets/uis/models/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<List<SongModel>> readLocalSongs() async {
  final audioQuery = OnAudioQuery();
  List<SongModel> songList=[];
    List<SongModel> localSongs = await audioQuery.querySongs(
      ignoreCase: false,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
      // uriType: UriType.INTERNAL,
    );
    print("fetching local songs");
    for(var k in localSongs){
      if(k.data.contains('?')||k.data.contains('#')){
        /* These files are not playable so removed */
      }else{
        songList.add(k);
      }
    }
    
    // print("localSongs: ${localSongs[0].displayName}");
    return songList;
}