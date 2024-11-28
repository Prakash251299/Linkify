import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/local_songs/player/prev_next_play.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPlayerButtons extends StatefulWidget {
  // SongModel songs;
  List<SongModel> songList = [];
  var name;
  var albumImg;
  var trackId;
  var trackArtists;
  var trackImg;
  SongPlayerButtons(
      this.songList, this.name, this.trackId, this.trackArtists, this.trackImg);

  @override
  State<SongPlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<SongPlayerButtons> {
  YoutubeSongPlayer _youtubePlayer = YoutubeSongPlayer();
  var playing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () async {
              if (StaticStore.player.position.inSeconds > 10) {
                await StaticStore.player.seek(Duration(
                    seconds: StaticStore.player.position.inSeconds - 10));
              } else {
                await StaticStore.player.seek(const Duration(seconds: 0));
              }
            },
            // : null,
            icon: const Icon(
              Icons.fast_rewind_rounded,
              color: Colors.white,
            )),
        IconButton(
          onPressed: () async {
            await play_prev_local(widget.songList);
          },
          iconSize: 45,
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.white,
          ),
        ),
        StreamBuilder<Object>(
            stream: StaticStore.player.playbackEventStream,
            builder: (context, snapshot) {
              return IconButton(
                onPressed: () async {
                  if (StaticStore.player.playing == true) {
                    _youtubePlayer.youtubePause();
                    StaticStore.playing = false;
                    StaticStore.pause = true;
                  } else {
                    _youtubePlayer.youtubeResume();
                    StaticStore.playing = true;
                    StaticStore.pause = false;
                  }

                  if (StaticStore.player.processingState ==
                      ProcessingState.completed) {
                    print("completed1");
                    await StaticStore.player.seek(const Duration(seconds: 0));
                  }
                },
                iconSize: 75,
                icon: StaticStore.playing == true
                    ? Icon(
                        Icons.pause,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      ),
              );
            }),
        IconButton(
          onPressed: () async {
            await play_next_local(widget.songList);
            setState(() {});
          },
          iconSize: 45,
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: () async {
              if (StaticStore.player.position.inSeconds + 10 <=
                  StaticStore.player.duration!.inSeconds) {
                await StaticStore.player.seek(Duration(
                    seconds: StaticStore.player.position.inSeconds + 10));
              } else {
                await StaticStore.player.seek(
                    Duration(seconds: StaticStore.player.duration!.inSeconds));
              }
            },
            icon: const Icon(
              Icons.fast_forward_rounded,
              color: Colors.white,
            ))
      ],
    );
  }
}
