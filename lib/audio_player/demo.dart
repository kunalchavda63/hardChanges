import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen to player state changes
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // Listen to duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://images.pexels.com/photos/127160/pexels-photo-127160.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                height: 400,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),

            // Song Title
            Text(
              "Song Title",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 28),
            ),
            SizedBox(height: 50),

            // Slider Section
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6.0), // Smaller thumb size
                overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 0.0), // No overlay
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
              ),
              child: Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (val) async {
                  // Seek to the new position
                  await audioPlayer.seek(Duration(seconds: val.toInt()));
                },
              ),
            ),

            // Duration Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.white70),
                ),
                Text(
                  formatTime(duration - position),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.white70),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await audioPlayer.seek(Duration.zero);
                  },
                  child: Icon(Icons.restart_alt, color: Colors.white, size: 45),
                ),
                InkWell(
                  child: Icon(Icons.skip_previous_rounded,
                      color: Colors.white, size: 45),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        String url =
                            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
                        await audioPlayer.play(UrlSource(url));
                      }
                    },
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ),
                InkWell(
                  child: Icon(Icons.skip_next,
                      color: Colors.white, size: 45),
                ),
                InkWell(
                  child: Icon(Icons.restart_alt_sharp,
                      color: Colors.white, size: 45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
