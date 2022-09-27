import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:music_player/model/songModelProvider.dart';

class NowPlaying extends StatefulWidget {
  final List<SongModel> songModelList;
  final AudioPlayer audioPlayer;

  const NowPlaying(
      {Key? key, required this.songModelList, required this.audioPlayer})
      : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _isPlaying = false;
  List<AudioSource> songList = [];

  int currentIndex = 0;

  void popBack() {
    Navigator.pop(context);
  }

  void seekToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  @override
  void initState() {
    super.initState();
    parseSong();
  }

  void parseSong() {
    try {
      for (var element in widget.songModelList) {
        songList.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              album: element.album ?? "No Album",
              title: element.displayNameWOExt,
              artUri: Uri.parse(element.id.toString()),
            ),
          ),
        );
      }

      widget.audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: songList),
      );
      widget.audioPlayer.play();
      _isPlaying = true;

      widget.audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          if(this.mounted){
            setState(() {
              _duration = duration;
            });
          }
        }
      });
      widget.audioPlayer.positionStream.listen((position) {
        if(this.mounted){
          setState(() {
            _position = position;
          });
        }
      });
      listenToEvent();
      listenToSongIndex();
    } on Exception catch (_) {
      popBack();
    }
  }

  void listenToEvent() {
    widget.audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        if(this.mounted){
          setState(() {
            _isPlaying = true;
          });
        }
      } else {
        if(this.mounted){
          setState(() {
            _isPlaying = false;
          });
        }
      }
      if (state.processingState == ProcessingState.completed) {
        if(this.mounted){
          setState(() {
            _isPlaying = false;
          });
        }
      }
    });
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen(
          (event) {
        if(this.mounted){
          setState(
                () {
              if (event != null) {
                currentIndex = event;
              }
              context
                  .read<SongModelProvider>()
                  .setId(widget.songModelList[currentIndex].id);
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.lightGreen.withOpacity(0.9),
                    Colors.greenAccent.withOpacity(0.1),
                  ]
              )
          ),
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  popBack();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: ArtWorkWidget(),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.songModelList[currentIndex].displayNameWOExt,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                          Text(
                            widget.songModelList[currentIndex].artist.toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                          thumbColor: Colors.white,
                          activeTrackColor: Colors.white,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),),
                      child: Slider(
                        min: 0.0,
                        value: _position.inSeconds.toDouble(),
                        max: _duration.inSeconds.toDouble() + 1.0,
                        onChanged: (value) {
                         if(this.mounted){
                           setState(
                                 () {
                               seekToSeconds(value.toInt());
                               value = value;
                             },
                           );
                         }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _position.toString().split(".")[0],
                          ),
                          Text(
                            _duration.toString().split(".")[0],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 40,
                              color: Colors.white,
                              onPressed: () {
                                if (widget.audioPlayer.hasPrevious) {
                                  widget.audioPlayer.seekToPrevious();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if(this.mounted){
                                  setState(() {
                                    if (_isPlaying) {
                                      widget.audioPlayer.pause();
                                    } else {
                                      if (_position >= _duration) {
                                        seekToSeconds(0);
                                      } else {
                                        widget.audioPlayer.play();
                                      }
                                    }
                                    _isPlaying = !_isPlaying;
                                  });
                                }
                              },
                              icon: Icon(
                                _isPlaying ? Icons.pause_circle : Icons.play_circle,

                              ),
                              color: Colors.white,
                              iconSize: 65.0,
                            ),
                            IconButton(
                              iconSize: 40.0,
                              color: Colors.white,
                              onPressed: () {
                                if (widget.audioPlayer.hasNext) {
                                  widget.audioPlayer.seekToNext();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_next,

                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(125.0),
      child: QueryArtworkWidget(
        id: context.watch<SongModelProvider>().id,
        type: ArtworkType.AUDIO,
        artworkHeight: 250,
        artworkWidth: 250,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: const Icon(
          Icons.music_note,
          size: 250,
        ),
      ),
    );
  }
}