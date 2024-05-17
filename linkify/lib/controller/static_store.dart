import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/first_page_categories.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/model/user_info.dart';
import 'package:spotify/spotify.dart';

class StaticStore{
  static var carouselLength = 6;
  // static List<Map<String,dynamic>>m1=[];
  // static List<Map<String,dynamic>>trackInfo=[
  //   {},
  //   {},
  //   {},
  //   {},
  //   {},
  //   {}
  // ];
  // static List<AlbumTrack>trackInfo=[];
  static List<List<AlbumTrack>>trackInfo=[
    [],
    [],
    [],
    [],
    [],
    []
  ];
  static List<String>? userGenre;
  // static List<Map<String,int>> userGenre=[];
  // static void setCarousel(){
  //   for(int i=0;i<carouselLength;i++){
  //     m1.add({});
  //   }
  // }
  static String dateStored = "1-1-2024";
  static String dateStored2 = "1-1-2024";
  static var carouselInd = -10;
  static var playingCarouselInd = -10;
  static var playing = false;
  static var currentSong = "";
  static var currentSongImg = "";
  static var currentArtists = [];
  static var pause = false;
  static AudioPlayer player = AudioPlayer();
  static var musicScreenEnabled = false;
  static String userSelectedArtists=""; // this string is comma separated artists name
  static String? currentUserGenreId="";
  static String? currentUserId="";
  static String? currentUserName="";
  static String? currentUserEmail="";
  static String? currentUserCountry="";
  static List<dynamic>? currentUserImage=[];
  // static String? currentUserImage="";
  static int videoPlayingIndex = -1;
  static List<FrontPageCategories>categoryInfo=[];
  static List<AlbumTrack> myQueueTrack=[];
  static int queueIndex = 0;
  static int queueLoaded = 0;
  static int nextPlay=1;
  static int screen = 0;
  // UserInfo _userInfo=[];
  static List<List<String>?>? requestStatusValue=[];

}