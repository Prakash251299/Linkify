import 'package:just_audio/just_audio.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/model/user_info.dart';
import 'package:spotify/spotify.dart';

class StaticStore{
  static var carouselLength = 6;
  static List<List<AlbumTrack>>trackInfo=[
    [],
    [],
    [],
    [],
    [],
    []
  ];
  static List<String>? userGenre;
  static Map<dynamic,dynamic>? userGenreWithCount;
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
  static int videoPlayingIndex = -1;
  static List<FrontPageCategories>categoryInfo=[];
  static List<AlbumTrack> myQueueTrack=[];
  static int queueIndex = 0;
  static int queueLoaded = 0;
  static int nextPlay=1;
  static int screen = 0;
  static List<List<String>?>? requestStatusValue=[[],[],[]];
  static int notificationCounts=0;
  static double miniplayerMargin=50;
  static int songIndex=0;
}