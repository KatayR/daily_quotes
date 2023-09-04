import 'package:audioplayers/audioplayers.dart';

class AudioHelper {
  static AudioPlayer player = AudioPlayer();

  static playMusic() async {
    player.setReleaseMode(ReleaseMode.loop);
    player.play(
      AssetSource(
        'sounds/testMusic.wav',
      ),
    );
  }

  static stopMusic() async {
    player.dispose();
    player = AudioPlayer();
    await player.stop();
    player.state = PlayerState.stopped;
  }

  static dispose() {
    player.dispose();
  }
}
